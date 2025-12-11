# Deployment Guide - Clipdash

## 🚀 Building for Production

### Step 1: Build the Project
```bash
npm run build
```

This creates an optimized production build in the `dist` folder with:
- Minified JavaScript
- Optimized CSS
- Compressed assets
- Tree-shaken code
- Source maps (optional)

### Step 2: Preview Production Build
```bash
npm run preview
```

This starts a local server to preview the production build before deploying.

## 📦 Deployment Options

### Option 1: Vercel (Recommended)

**Why Vercel?**
- Zero configuration for Vite projects
- Automatic HTTPS
- Global CDN
- Free tier available
- Automatic deployments from Git

**Steps:**
1. Push your code to GitHub
2. Go to [vercel.com](https://vercel.com)
3. Click "Import Project"
4. Select your repository
5. Click "Deploy"

**Environment Variables (if needed):**
```
VITE_API_URL=https://api.clipdash.com
```

### Option 2: Netlify

**Steps:**
1. Push your code to GitHub
2. Go to [netlify.com](https://netlify.com)
3. Click "New site from Git"
4. Select your repository
5. Build settings:
   - Build command: `npm run build`
   - Publish directory: `dist`
6. Click "Deploy site"

**netlify.toml Configuration:**
```toml
[build]
  command = "npm run build"
  publish = "dist"

[[redirects]]
  from = "/*"
  to = "/index.html"
  status = 200
```

### Option 3: GitHub Pages

**Steps:**
1. Update `vite.config.ts`:
```typescript
export default defineConfig({
  plugins: [react()],
  base: '/your-repo-name/',
})
```

2. Install gh-pages:
```bash
npm install --save-dev gh-pages
```

3. Add to `package.json`:
```json
"scripts": {
  "predeploy": "npm run build",
  "deploy": "gh-pages -d dist"
}
```

4. Deploy:
```bash
npm run deploy
```

### Option 4: AWS S3 + CloudFront

**Steps:**
1. Build the project: `npm run build`
2. Create S3 bucket with static website hosting
3. Upload `dist` folder contents
4. Create CloudFront distribution
5. Point domain to CloudFront

**AWS CLI Commands:**
```bash
aws s3 sync dist/ s3://your-bucket-name --delete
aws cloudfront create-invalidation --distribution-id YOUR_DIST_ID --paths "/*"
```

### Option 5: Docker

**Dockerfile:**
```dockerfile
# Build stage
FROM node:18-alpine as build
WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY . .
RUN npm run build

# Production stage
FROM nginx:alpine
COPY --from=build /app/dist /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
```

**nginx.conf:**
```nginx
server {
    listen 80;
    server_name localhost;
    root /usr/share/nginx/html;
    index index.html;

    location / {
        try_files $uri $uri/ /index.html;
    }
}
```

**Build and run:**
```bash
docker build -t clipdash .
docker run -p 80:80 clipdash
```

### Option 6: Custom Server (Node.js + Express)

**server.js:**
```javascript
const express = require('express');
const path = require('path');
const app = express();

app.use(express.static(path.join(__dirname, 'dist')));

app.get('*', (req, res) => {
  res.sendFile(path.join(__dirname, 'dist', 'index.html'));
});

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});
```

## 🔧 Configuration

### Environment Variables

Create `.env.production`:
```env
VITE_API_BASE_URL=https://api.clipdash.com/v1
VITE_APP_NAME=Clipdash
VITE_MAX_FILE_SIZE=524288000
```

Access in code:
```typescript
const apiUrl = import.meta.env.VITE_API_BASE_URL;
```

### Build Optimization

**vite.config.ts:**
```typescript
export default defineConfig({
  plugins: [react()],
  build: {
    target: 'esnext',
    minify: 'terser',
    sourcemap: false,
    rollupOptions: {
      output: {
        manualChunks: {
          'react-vendor': ['react', 'react-dom', 'react-router-dom'],
          'chart-vendor': ['recharts'],
        }
      }
    }
  }
})
```

## 📊 Pre-Deployment Checklist

### Code Quality
- [ ] No console.log statements in production code
- [ ] No linting errors (`npm run lint`)
- [ ] TypeScript errors resolved
- [ ] All tests passing (if applicable)

### Performance
- [ ] Images optimized
- [ ] Code splitting implemented
- [ ] Lazy loading for routes
- [ ] Bundle size analyzed

### Security
- [ ] API keys moved to environment variables
- [ ] HTTPS enabled
- [ ] CORS configured properly
- [ ] Security headers set

### SEO & Metadata
- [ ] Title and meta tags updated
- [ ] Favicon set
- [ ] robots.txt created (if needed)
- [ ] sitemap.xml created (if needed)

### Testing
- [ ] Test login flow
- [ ] Test video upload
- [ ] Test all navigation links
- [ ] Test on multiple browsers
- [ ] Test responsive design
- [ ] Test error states

## 🔒 Security Headers

Add these headers to your server/CDN:

```
Content-Security-Policy: default-src 'self'; script-src 'self' 'unsafe-inline'; style-src 'self' 'unsafe-inline'
X-Frame-Options: SAMEORIGIN
X-Content-Type-Options: nosniff
Referrer-Policy: strict-origin-when-cross-origin
Permissions-Policy: geolocation=(), microphone=(), camera=()
```

## 📈 Monitoring

### Analytics (Optional)
Add Google Analytics, Plausible, or similar:

```html
<!-- In index.html -->
<script async src="https://www.googletagmanager.com/gtag/js?id=GA_TRACKING_ID"></script>
```

### Error Tracking
Consider adding:
- Sentry for error tracking
- LogRocket for session replay
- New Relic for performance monitoring

## 🌐 Custom Domain

### DNS Settings
For most providers:
- Type: A Record or CNAME
- Name: @ or www
- Value: Your deployment IP/URL

**Example (Vercel):**
```
Type: CNAME
Name: www
Value: cname.vercel-dns.com
```

## 🔄 CI/CD Pipeline

### GitHub Actions Example

**.github/workflows/deploy.yml:**
```yaml
name: Deploy

on:
  push:
    branches: [main]

jobs:
  deploy:
    runs-on: ubuntu-latest
    
    steps:
      - uses: actions/checkout@v3
      
      - name: Setup Node.js
        uses: actions/setup-node@v3
        with:
          node-version: '18'
          
      - name: Install dependencies
        run: npm ci
        
      - name: Build
        run: npm run build
        
      - name: Deploy to Vercel
        uses: amondnet/vercel-action@v20
        with:
          vercel-token: ${{ secrets.VERCEL_TOKEN }}
          vercel-org-id: ${{ secrets.ORG_ID }}
          vercel-project-id: ${{ secrets.PROJECT_ID }}
```

## 🐛 Troubleshooting

### Issue: Blank page after deployment
**Solution:** Check browser console, ensure base path is correct

### Issue: 404 on page refresh
**Solution:** Configure server to redirect all routes to index.html

### Issue: Environment variables not working
**Solution:** Ensure they're prefixed with `VITE_`

### Issue: Build size too large
**Solution:** Analyze bundle with `npm run build -- --report`

## 📝 Post-Deployment

1. **Test thoroughly** on production URL
2. **Monitor** for errors in first 24 hours
3. **Set up backups** of database (when applicable)
4. **Document** deployment process for team
5. **Set up monitoring** and alerts

## 🎉 Success!

Your Clipdash application is now live! 🚀

### Share Your Deployment
- Tweet about it
- Add to portfolio
- Share with team
- Get user feedback

---

Need help? Check the main README or open an issue on GitHub.







