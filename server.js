import express from 'express';
import session from 'express-session';
import bodyParser from 'body-parser';
import { v4 as uuid } from 'uuid';
import fs from 'fs';
import path from 'path';

const app = express();
const PORT = process.env.PORT || 3000;

// Configure session
app.use(session({
  secret: 'super-secret-key',
  resave: false,
  saveUninitialized: true,
}));

app.use(bodyParser.urlencoded({ extended: false }));
app.use(express.static('public'));
app.set('view engine', 'ejs');

// Data paths
const dataDir = './data';
const usersPath = path.join(dataDir, 'users.json');
const postsPath = path.join(dataDir, 'posts.json');
const tipsPath = path.join(dataDir, 'tips.json');

// Ensure data directory exists
if (!fs.existsSync(dataDir)) {
  fs.mkdirSync(dataDir);
}

function loadJson(p) {
  if (!fs.existsSync(p)) return [];
  return JSON.parse(fs.readFileSync(p, 'utf8'));
}

function saveJson(p, data) {
  fs.writeFileSync(p, JSON.stringify(data, null, 2));
}

// Seed admin and influencer users if not exist
const users = loadJson(usersPath);
if (users.length === 0) {
  users.push(
    { id: uuid(), username: 'admin', password: 'admin', role: 'admin' },
    { id: uuid(), username: 'influencer', password: 'influencer', role: 'influencer' }
  );
  saveJson(usersPath, users);
}

function requireAuth(role) {
  return (req, res, next) => {
    if (!req.session.user || (role && req.session.user.role !== role)) {
      return res.redirect('/login');
    }
    next();
  };
}

app.get('/', (req, res) => {
  const posts = loadJson(postsPath);
  res.render('index', { user: req.session.user, posts });
});

app.get('/register', (req, res) => {
  res.render('register');
});

app.post('/register', (req, res) => {
  const { username, password } = req.body;
  const users = loadJson(usersPath);
  if (users.find(u => u.username === username)) {
    return res.send('Username already exists');
  }
  const user = { id: uuid(), username, password, role: 'fan' };
  users.push(user);
  saveJson(usersPath, users);
  req.session.user = user;
  res.redirect('/');
});

app.get('/login', (req, res) => {
  res.render('login');
});

app.post('/login', (req, res) => {
  const { username, password } = req.body;
  const users = loadJson(usersPath);
  const user = users.find(u => u.username === username && u.password === password);
  if (!user) return res.send('Invalid credentials');
  req.session.user = user;
  res.redirect('/');
});

app.get('/logout', (req, res) => {
  req.session.destroy(() => {
    res.redirect('/');
  });
});

// Influencer dashboard
app.get('/influencer', requireAuth('influencer'), (req, res) => {
  const posts = loadJson(postsPath);
  const tips = loadJson(tipsPath);
  res.render('influencer', { user: req.session.user, posts, tips });
});

app.post('/create-post', requireAuth('influencer'), (req, res) => {
  const { type, content } = req.body;
  const posts = loadJson(postsPath);
  posts.push({ id: uuid(), authorId: req.session.user.id, type, content, hearts: 0, comments: [] });
  saveJson(postsPath, posts);
  res.redirect('/influencer');
});

// Fan actions
app.post('/posts/:id/heart', requireAuth('fan'), (req, res) => {
  const posts = loadJson(postsPath);
  const post = posts.find(p => p.id === req.params.id);
  if (post) {
    post.hearts = (post.hearts || 0) + 1;
    saveJson(postsPath, posts);
  }
  res.redirect('/');
});

app.post('/posts/:id/comment', requireAuth('fan'), (req, res) => {
  const { comment } = req.body;
  const posts = loadJson(postsPath);
  const post = posts.find(p => p.id === req.params.id);
  if (post) {
    post.comments.push({ userId: req.session.user.id, text: comment });
    saveJson(postsPath, posts);
  }
  res.redirect('/');
});

app.post('/posts/:id/tip', requireAuth('fan'), (req, res) => {
  const { amount, message } = req.body;
  const tips = loadJson(tipsPath);
  const tip = { id: uuid(), postId: req.params.id, fanId: req.session.user.id, amount, message, hearted: false };
  tips.push(tip);
  saveJson(tipsPath, tips);
  res.redirect('/');
});

app.post('/tips/:id/heart', requireAuth('influencer'), (req, res) => {
  const tips = loadJson(tipsPath);
  const tip = tips.find(t => t.id === req.params.id);
  if (tip) {
    tip.hearted = true;
    saveJson(tipsPath, tips);
  }
  res.redirect('/influencer');
});

// Admin page
app.get('/admin', requireAuth('admin'), (req, res) => {
  const users = loadJson(usersPath);
  const posts = loadJson(postsPath);
  const tips = loadJson(tipsPath);
  res.render('admin', { users, posts, tips });
});

app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});

