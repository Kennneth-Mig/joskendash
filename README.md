# Clipdash - AI Video Editing Platform

A modern, responsive web application for an AI-powered video editing service that automatically removes filler words ("umms", "ahhs") from videos. The platform provides an API for developers and a user-friendly dashboard for managing video editing tasks.

![Clipdash](https://via.placeholder.com/1200x600/3b82f6/ffffff?text=Clipdash+-+AI+Video+Editing+Platform)

## Features

- 🎥 **Video Upload & Processing**: Drag-and-drop interface for easy video uploads
- 🤖 **AI-Powered Editing**: Automatically removes filler words and long pauses
- 📊 **Analytics Dashboard**: Track processing metrics and time saved
- 📈 **Data Visualization**: Beautiful charts showing video processing trends
- ⚙️ **Customizable Settings**: Configure filler word removal preferences
- 🔑 **API Access**: RESTful API for programmatic video processing
- 📚 **Comprehensive Documentation**: Complete API reference with code examples
- 🎨 **Modern UI**: Clean, responsive design with smooth animations

## Tech Stack

- **Frontend**: React 18 with TypeScript
- **Styling**: Tailwind CSS
- **Routing**: React Router v6
- **State Management**: Zustand
- **Icons**: Lucide React
- **Charts**: Recharts
- **Build Tool**: Vite

## Getting Started

### Prerequisites

- Node.js 16+ and npm/yarn

### Installation

1. Clone the repository:
```bash
git clone <repository-url>
cd DashClip
```

2. Install dependencies:
```bash
npm install
```

3. Start the development server:
```bash
npm run dev
```

4. Open your browser and navigate to `http://localhost:3000`

### Demo Credentials

Use these credentials to log in:
- **Email**: `clipdash@gmail.com`
- **Password**: `zxcvzxcv`

## Project Structure

```
src/
├── components/
│   ├── auth/              # (Integrated in pages)
│   ├── layout/
│   │   ├── Sidebar.tsx
│   │   ├── Header.tsx
│   │   └── MainLayout.tsx
│   ├── dashboard/
│   │   ├── MetricsCard.tsx
│   │   ├── StatusChart.tsx
│   │   └── DashboardView.tsx
│   ├── editor/
│   │   ├── VideoUpload.tsx
│   │   ├── VideoTable.tsx
│   │   └── EditorView.tsx
│   ├── settings/
│   │   └── SettingsView.tsx
│   ├── documentation/
│   │   └── DocumentationView.tsx
│   └── common/
│       ├── Modal.tsx
│       └── Button.tsx
├── store/
│   ├── authStore.ts
│   └── videoStore.ts
├── pages/
│   ├── Login.tsx
│   ├── Signup.tsx
│   ├── Dashboard.tsx
│   ├── Editor.tsx
│   ├── Settings.tsx
│   └── Documentation.tsx
├── types/
│   └── index.ts
└── App.tsx
```

## Features Overview

### 1. Authentication
- Secure login and signup pages
- Demo credentials for testing
- Protected routes
- Logout functionality with confirmation modal

### 2. Dashboard
- **Metrics Cards**: Total videos, completed, pending, time saved
- **Area Chart**: Video processing trends over time
- **Recent Activity**: Table showing latest video processing activity
- Real-time updates

### 3. Video Editor
- **Upload Interface**: Drag-and-drop with progress tracking
- **Video Library**: Searchable table with all videos
- **Status Indicators**: Visual status badges and progress bars
- **Actions**: Preview, download, and delete videos
- **Inline Editing**: Rename videos directly in the table
- **Pagination**: Navigate through large video collections

### 4. Settings
Multiple configuration sections:
- **Profile**: Update name and avatar
- **Processing Preferences**: 
  - Select filler words to remove
  - Adjust aggressiveness slider
- **API Settings**: 
  - View and copy API key
  - Regenerate API key
  - Monitor usage limits
- **Notifications**: Configure email alerts

### 5. Documentation
- Interactive API documentation
- Code examples in multiple languages (JavaScript, Python, cURL)
- Copy-to-clipboard functionality
- Complete endpoint reference
- Rate limits information
- Changelog

## Key Components

### Collapsible Sidebar
- Smooth expand/collapse animation
- Active route highlighting
- User profile section with logout option
- Responsive design

### Video Processing Simulation
- Automatic progress updates
- Status transitions (uploading → processing → completed)
- Real-time UI updates

### Data Visualization
- Beautiful area charts with gradients
- Responsive design
- Interactive tooltips

## Available Scripts

- `npm run dev` - Start development server
- `npm run build` - Build for production
- `npm run preview` - Preview production build
- `npm run lint` - Run ESLint

## Color Palette

```css
Primary:    #3b82f6 (Blue)
Secondary:  #8b5cf6 (Purple)
Success:    #10b981 (Green)
Warning:    #f59e0b (Orange)
Error:      #ef4444 (Red)
Background: #f9fafb (Light Gray)
Sidebar:    #1f2937 (Dark Gray)
```

## Responsive Design

The application is fully responsive:
- **Mobile**: Hamburger menu, stacked layout
- **Tablet**: Collapsed sidebar by default
- **Desktop**: Full expanded sidebar experience

## Future Enhancements

- [ ] Real backend integration
- [ ] Actual video processing with AI
- [ ] Webhook support
- [ ] Batch video processing
- [ ] Video preview player
- [ ] Advanced analytics
- [ ] Team collaboration features
- [ ] Payment integration
- [ ] Video transcription

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License.

## Support

For support, email clipdash@gmail.com or open an issue in the repository.

---

Built with ❤️ using React, TypeScript, and Tailwind CSS







