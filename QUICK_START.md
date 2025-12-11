# Quick Start Guide - Clipdash

## Installation & Setup

Follow these simple steps to get Clipdash running on your local machine:

### Step 1: Install Dependencies
```bash
npm install
```

This will install all required packages including:
- React 18
- TypeScript
- Tailwind CSS
- React Router
- Zustand
- Recharts
- Lucide React

### Step 2: Start Development Server
```bash
npm run dev
```

The application will start on `http://localhost:3000` and automatically open in your browser.

### Step 3: Login
Use the demo credentials:
- **Email**: `clipdash@gmail.com`
- **Password**: `zxcvzxcv`

## Application Features

### 🎯 Main Navigation

Once logged in, you'll see a collapsible sidebar with four main sections:

1. **Dashboard** - Overview with metrics, charts, and recent activity
2. **Editor** - Upload and manage videos
3. **Settings** - Configure preferences and API settings
4. **Documentation** - Complete API reference

### 📊 Dashboard
- View total videos, completed, pending, and time saved
- Interactive chart showing processing trends
- Recent activity table

### 🎬 Editor
- Drag-and-drop video upload
- Real-time processing simulation
- Search and filter videos
- Edit video names inline
- Preview, download, and delete actions

### ⚙️ Settings
Four tabs:
- **Profile**: Update your name and avatar
- **Processing**: Configure filler word removal preferences
- **API**: View API key and usage limits
- **Notifications**: Manage email alerts

### 📚 Documentation
- Complete API reference
- Code examples in JavaScript, Python, and cURL
- Copy-to-clipboard functionality
- Rate limits and changelog

## Interactive Features to Try

### 1. Sidebar Toggle
- Click the circle button with arrows on the sidebar to collapse/expand it
- Notice how icons stay visible while text fades out

### 2. Upload a Video
1. Go to Editor
2. Drag a video file or click "Select File"
3. Watch the upload progress
4. See the video automatically start "processing"
5. Progress bar shows completion status

### 3. Edit Video Names
- In the Editor table, click the pencil icon next to any video name
- Edit the name inline
- Click the checkmark to save or X to cancel

### 4. View Dashboard Analytics
- Check out the area chart showing video processing trends
- Hover over data points for detailed information

### 5. Explore API Documentation
- Navigate to Documentation
- Switch between different sections using the sidebar
- Try the language switchers on code examples (JS/Python/cURL)
- Click copy buttons to copy code snippets

### 6. Configure Settings
- Go to Settings
- Switch between tabs
- Adjust the aggressiveness slider
- Toggle notification preferences
- Copy your API key

### 7. Logout
- Click your user profile at the bottom of the sidebar
- Confirm logout in the modal

## Build for Production

```bash
npm run build
```

This creates an optimized production build in the `dist` folder.

To preview the production build:
```bash
npm run preview
```

## Troubleshooting

### Port Already in Use
If port 3000 is already in use, Vite will automatically use the next available port (3001, 3002, etc.)

### Dependencies Installation Issues
Try:
```bash
rm -rf node_modules package-lock.json
npm install
```

### TypeScript Errors
Make sure you're using Node.js 16 or higher:
```bash
node --version
```

## Project Structure Quick Reference

```
src/
├── components/      # Reusable UI components
├── pages/          # Page components
├── store/          # Zustand state management
├── types/          # TypeScript type definitions
├── App.tsx         # Main app with routing
├── main.tsx        # Entry point
└── index.css       # Global styles
```

## Demo Data

The application comes with 15 pre-populated sample videos showing various statuses:
- **Completed**: Videos that have been processed
- **Pending**: Videos waiting to be processed
- **Processing**: Videos currently being edited (with progress bars)
- **Failed**: Videos that encountered errors

## Next Steps

1. Explore all four main sections
2. Try uploading videos and watch them process
3. Check out the API documentation
4. Customize settings to your preferences
5. Review the code structure for customization

## Need Help?

- Check the main README.md for detailed documentation
- All demo credentials are displayed on the login page
- The app includes helpful tooltips and hints throughout

---

Enjoy using Clipdash! 🎉







