"use client";

import * as THREE from "three";
import { useRef, useState, useEffect } from "react";
import { Canvas, useFrame } from "@react-three/fiber";
import { Clouds, Cloud, CameraControls, Sky as SkyImpl } from "@react-three/drei";
import { Coffee, Play, Pause, Copy, Check } from "lucide-react";
import { Button } from "@/components/ui/button";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";

export default function Home() {
  const [activeLabels, setActiveLabels] = useState<Set<string>>(new Set());
  const [buttonSize, setButtonSize] = useState('120px');
  const [currentStep, setCurrentStep] = useState(0);
  const [copied, setCopied] = useState(false);

  const onboardingSteps: Array<{
    title: string;
    description: string;
    action: string;
    link: string;
    cta: string;
    command?: string;
    logo?: string;
  }> = [
    {
      title: "Initialize Project",
      description: "Bootstrap your entire production-ready stack in one command. TypeScript, tRPC, Drizzle, and everything you need.",
      action: "Copy the command below",
      link: "https://github.com/cbarrett3/webchella",
      cta: "View Repository",
      command: "curl -sSL https://raw.githubusercontent.com/cbarrett3/webchella/main/templates/setup-script.sh | bash -s my-app"
    },
    {
      title: "Connect Your Database",
      description: "Create your Supabase project and grab your credentials from the dashboard.",
      action: "Create your Supabase project",
      link: "https://supabase.com/dashboard",
      cta: "Go to Supabase",
      logo: "/supabase.png"
    },
    {
      title: "Define Your Schema",
      description: "Model your data with Drizzle. Write migrations and push to Supabase.",
      action: "Review Drizzle setup",
      link: "https://orm.drizzle.team/docs/tutorials/drizzle-with-postgres",
      cta: "View Drizzle Docs",
      logo: "/drizzle.png"
    },
    {
      title: "Secure Your App",
      description: "Configure Better Auth and add your environment variables.",
      action: "Configure authentication",
      link: "https://www.better-auth.com/docs",
      cta: "View Better Auth Docs",
      logo: "/betterauth.svg"
    },
    {
      title: "Enable Payments (Optional)",
      description: "Add Stripe for subscriptions and payments. Skip if not needed.",
      action: "Create Stripe account",
      link: "https://dashboard.stripe.com/register",
      cta: "Go to Stripe",
      logo: "/stripe.png"
    },
    {
      title: "Enable Email (Optional)",
      description: "Add Resend for transactional emails. Skip if not needed.",
      action: "Create Resend account",
      link: "https://resend.com/signup",
      cta: "Go to Resend",
      logo: "/resend.png"
    },
    {
      title: "Ship",
      description: "Everything's configured. Start building with your AI agent.",
      action: "Start your development server",
      link: "https://github.com/cbarrett3/webchella",
      cta: "View Framework Docs"
    }
  ];

  const toggleLabel = (labelName: string) => {
    setActiveLabels(prev => {
      const newSet = new Set(prev);
      if (newSet.has(labelName)) {
        newSet.delete(labelName);
      } else {
        newSet.add(labelName);
      }
      return newSet;
    });
  };

  useEffect(() => {
    const updateButtonSize = () => {
      const width = window.innerWidth;
      if (width >= 1536) { // 2xl
        setButtonSize('280px'); // Further reduced from 360px
      } else if (width >= 1280) { // xl
        setButtonSize('240px'); // Further reduced from 300px
      } else if (width >= 1024) { // lg
        setButtonSize('200px'); // Further reduced from 240px
      } else if (width >= 768) { // md
        setButtonSize('160px'); // Further reduced from 200px
      } else if (width >= 640) { // sm
        setButtonSize('140px'); // Further reduced from 160px
      } else {
        setButtonSize('120px'); // Keep small screens the same
      }
    };

    updateButtonSize();
    window.addEventListener('resize', updateButtonSize);
    return () => window.removeEventListener('resize', updateButtonSize);
  }, []);

  return (
    <main className="bg-white relative">
      {/* Three.js Canvas - Full Screen */}
      <div className="absolute inset-0 w-full h-full">
        <Canvas 
          camera={{ position: [0, 0, 5], fov: 75 }}
          style={{ width: '100%', height: '100%' }}
        >
          <Sky />
          <ambientLight intensity={Math.PI / 1.5} />
          <spotLight position={[0, 40, 0]} decay={0} distance={45} penumbra={1} intensity={100} />
          <spotLight position={[-20, 0, 10]} color="red" angle={0.15} decay={0} penumbra={-1} intensity={30} />
          <spotLight position={[20, -10, 10]} color="red" angle={0.2} decay={0} penumbra={-1} intensity={20} />
          <CameraControls />
        </Canvas>
      </div>

        {/* Buy Me a Coffee Link - Top Left */}
        <a
          href="https://venmo.com/cbarrett-97"
          target="_blank"
          rel="noopener noreferrer"
          className="fixed top-6 left-6 z-50 group"
          aria-label="Buy me a coffee"
        >
          <div className="bg-white/10 hover:bg-white/20 backdrop-blur-lg rounded-full p-3 transition-all duration-300 hover:scale-110 hover:shadow-xl relative w-12 h-12 flex items-center justify-center" style={{
            border: '2px solid transparent',
            backgroundImage: 'linear-gradient(45deg, #ff6b6b, #4ecdc4, #45b7d1, #96ceb4, #feca57, #ff9ff3, #54a0ff), linear-gradient(45deg, rgba(255,255,255,0.1), rgba(255,255,255,0.1))',
            backgroundOrigin: 'border-box',
            backgroundClip: 'padding-box, border-box'
          }}>
            <span className="text-2xl">☕</span>
          </div>
        </a>

        {/* GitHub Link - Top Right */}
        <a
          href="https://github.com/cbarrett3/webchella"
          target="_blank"
          rel="noopener noreferrer"
          className="fixed top-6 right-6 z-50 group"
          aria-label="View on GitHub"
        >
          <div className="bg-white/10 hover:bg-white/20 backdrop-blur-lg rounded-full p-3 transition-all duration-300 hover:scale-110 hover:shadow-xl relative" style={{
            border: '2px solid transparent',
            backgroundImage: 'linear-gradient(45deg, #ff6b6b, #4ecdc4, #45b7d1, #96ceb4, #feca57, #ff9ff3, #54a0ff), linear-gradient(45deg, rgba(255,255,255,0.1), rgba(255,255,255,0.1))',
            backgroundOrigin: 'border-box',
            backgroundClip: 'padding-box, border-box'
          }}>
            <svg
              className="w-6 h-6 text-white group-hover:text-gray-200 transition-colors duration-300"
              fill="currentColor"
              viewBox="0 0 24 24"
              aria-hidden="true"
            >
              <path fillRule="evenodd" d="M12 2C6.477 2 2 6.484 2 12.017c0 4.425 2.865 8.18 6.839 9.504.5.092.682-.217.682-.483 0-.237-.008-.868-.013-1.703-2.782.605-3.369-1.343-3.369-1.343-.454-1.158-1.11-1.466-1.11-1.466-.908-.62.069-.608.069-.608 1.003.07 1.531 1.032 1.531 1.032.892 1.53 2.341 1.088 2.91.832.092-.647.35-1.088.636-1.338-2.22-.253-4.555-1.113-4.555-4.951 0-1.093.39-1.988 1.029-2.688-.103-.253-.446-1.272.098-2.65 0 0 .84-.27 2.75 1.026A9.564 9.564 0 0112 6.844c.85.004 1.705.115 2.504.337 1.909-1.296 2.747-1.027 2.747-1.027.546 1.379.202 2.398.1 2.651.64.7 1.028 1.595 1.028 2.688 0 3.848-2.339 4.695-4.566 4.943.359.309.678.92.678 1.855 0 1.338-.012 2.419-.012 2.747 0 .268.18.58.688.482A10.019 10.019 0 0022 12.017C22 6.484 17.522 2 12 2z" clipRule="evenodd" />
            </svg>

          </div>
        </a>

        {/* Content */}
      <div className="relative z-10 flex flex-col items-center justify-center min-h-screen py-4">
        {/* Rope for the disco ball */}
        <div className="absolute top-0 left-0 w-full h-full pointer-events-none z-10">
          <svg 
            className="w-full h-full" 
            viewBox="0 0 100 100" 
            preserveAspectRatio="none"
            style={{ 
              position: 'absolute',
              top: 0,
              left: 0,
              width: '100%',
              height: '100%',
              animation: 'rope-sway 4s ease-in-out infinite'
            }}
          >
            {/* Main rope line - always goes through center (50, 50) */}
            <path
              d="M 0 15 Q 50 50 100 15"
              stroke="rgba(255, 255, 255, 0.4)"
              strokeWidth="0.4"
              fill="none"
              strokeLinecap="round"
              strokeDasharray="0.8,0.4"
            />
            {/* Rope texture */}
            <path
              d="M 0 15 Q 50 50 100 15"
              stroke="rgba(200, 200, 200, 0.6)"
              strokeWidth="0.2"
              fill="none"
              strokeLinecap="round"
              strokeDasharray="0.2,0.6"
            />
            {/* Rope highlight */}
            <path
              d="M 0 15 Q 50 50 100 15"
              stroke="rgba(255, 255, 255, 0.8)"
              strokeWidth="0.1"
              fill="none"
              strokeLinecap="round"
              strokeDasharray="0.1,0.9"
            />
          </svg>
        </div>

        {/* Big Play/Stop Button */}
        <div className="flex justify-center mb-8 mt-2">
        <button 
          id="big-play-button"
          className="group relative bg-white/5 hover:bg-white/8 backdrop-blur-sm rounded-full transition-all duration-500 hover:scale-105 hover:shadow-2xl border-2 overflow-hidden cursor-pointer z-30"
          style={{
            width: buttonSize,
            height: buttonSize,
            padding: '24px',
            boxShadow: '0 0 0 0 rgba(255, 0, 128, 0.1), inset 0 0 0 0 rgba(255, 128, 0, 0.05)',
            transition: 'all 0.5s cubic-bezier(0.4, 0, 0.2, 1)',
            position: 'relative',
            borderColor: 'rgba(255, 0, 128, 0.3)'
          }}
          onMouseMove={(e) => {
            const button = e.currentTarget;
            const rect = button.getBoundingClientRect();
            const x = e.clientX - rect.left;
            const y = e.clientY - rect.top;
            const centerX = rect.width / 2;
            const centerY = rect.height / 2;
            
            // Check if audio is paused to determine ripple color
            const audio = document.getElementById('coding-audio') as HTMLAudioElement;
            const isPaused = audio.paused;
            
            // Create ripple effect
            const ripple = document.createElement('div');
            ripple.style.position = 'absolute';
            ripple.style.left = `${x}px`;
            ripple.style.top = `${y}px`;
            ripple.style.width = '0px';
            ripple.style.height = '0px';
            
            if (isPaused) {
              // Dreamy cloud-colored ripples when paused
              ripple.style.background = 'radial-gradient(circle, rgba(255,182,193,0.3) 0%, rgba(255,218,185,0.2) 30%, rgba(221,160,221,0.15) 60%, transparent 100%)';
            } else {
              // Soft white ripples when playing
              ripple.style.background = 'radial-gradient(circle, rgba(255,255,255,0.2) 0%, rgba(255,255,255,0.1) 50%, transparent 100%)';
            }
            
            ripple.style.borderRadius = '50%';
            ripple.style.transform = 'translate(-50%, -50%)';
            ripple.style.pointerEvents = 'none';
            ripple.style.animation = 'ripple 0.8s ease-out';
            ripple.style.zIndex = '1';
            
            button.appendChild(ripple);
            
            setTimeout(() => {
              if (ripple.parentNode) {
                ripple.parentNode.removeChild(ripple);
              }
            }, 800);
          }}
          onMouseEnter={(e) => {
            if (e.currentTarget) {
              const audio = document.getElementById('coding-audio') as HTMLAudioElement;
              if (audio.paused) {
                // Disco colors when paused
                e.currentTarget.style.boxShadow = '0 0 40px rgba(255, 0, 128, 0.4), inset 0 0 20px rgba(255, 128, 0, 0.2)';
                e.currentTarget.style.borderColor = 'rgba(255, 0, 128, 0.8)';
              } else {
                // White when playing
                e.currentTarget.style.boxShadow = '0 0 40px rgba(255, 255, 255, 0.3), inset 0 0 20px rgba(255, 255, 255, 0.1)';
                e.currentTarget.style.borderColor = 'rgba(255, 255, 255, 0.7)';
              }
            }
          }}
          onMouseLeave={(e) => {
            if (e.currentTarget) {
              const audio = document.getElementById('coding-audio') as HTMLAudioElement;
              if (audio.paused) {
                // Disco colors when paused
                e.currentTarget.style.boxShadow = '0 0 0 0 rgba(255, 0, 128, 0.2), inset 0 0 0 0 rgba(255, 128, 0, 0.1)';
                e.currentTarget.style.borderColor = 'rgba(255, 0, 128, 0.5)';
              } else {
                // White when playing
                e.currentTarget.style.boxShadow = '0 0 0 0 rgba(255, 255, 255, 0.1), inset 0 0 0 0 rgba(255, 255, 255, 0.05)';
                e.currentTarget.style.borderColor = 'rgba(255, 255, 255, 0.3)';
              }
            }
          }}
          onClick={() => {
            const audio = document.getElementById('coding-audio') as HTMLAudioElement;
            const button = document.getElementById('big-play-button');
            const discoEffect = document.getElementById('disco-effect');
            const testIndicator = document.getElementById('test-indicator');
            
            console.log('Button clicked! Audio paused:', audio.paused);
            console.log('Disco effect element:', discoEffect);
            console.log('Test indicator element:', testIndicator);
            
            if (audio.paused) {
              audio.play();
              console.log('Playing audio, showing disco effect');
              
              // Show test indicator
              if (testIndicator) {
                testIndicator.style.display = 'block';
                console.log('Test indicator should be visible (red circle)');
              }
              
              // Show disco effect
              if (discoEffect) {
                discoEffect.style.display = 'block';
                discoEffect.style.animation = 'disco 3s linear infinite';
                // Dreamy, faded, distorted disco
                discoEffect.style.background = 'conic-gradient(from 0deg, rgba(255,0,128,0.6), rgba(255,128,0,0.5), rgba(255,255,0,0.4), rgba(128,255,0,0.5), rgba(0,255,128,0.6), rgba(0,128,255,0.4), rgba(128,0,255,0.5), rgba(255,0,128,0.6))';
                discoEffect.style.filter = 'blur(2px) saturate(1.8) brightness(1.2)';
                discoEffect.style.opacity = '0.7';
                console.log('Disco effect should be visible now');
              }
            } else {
              audio.pause();
              console.log('Pausing audio, hiding disco effect');
              
              // Hide test indicator
              if (testIndicator) {
                testIndicator.style.display = 'none';
              }
              
              // Hide disco effect
              if (discoEffect) {
                discoEffect.style.display = 'none';
                discoEffect.style.animation = 'none';
              }
            }
          }}
        >
          {/* Disco Effect - Hidden by default */}
          <div 
            id="disco-effect"
            className="absolute inset-0 rounded-full"
            style={{
              display: 'none',
              background: 'conic-gradient(from 0deg, #ff0080, #ff8000, #ffff00, #80ff00, #00ff80, #0080ff, #8000ff, #ff0080)',
              animation: 'disco 2s linear infinite',
              opacity: '1',
              zIndex: '20',
              position: 'absolute',
              top: '0',
              left: '0',
              right: '0',
              bottom: '0',
              width: '100%',
              height: '100%'
            }}
          />
          
          {/* Test indicator - always visible for debugging */}
          <div 
            id="test-indicator"
            className="absolute inset-0 rounded-full bg-red-500 opacity-50"
            style={{
              display: 'none',
              zIndex: '5'
            }}
          />
        </button>
      </div>
      
      {/* Hidden audio element */}
      <audio 
        id="coding-audio" 
        loop 
        preload="auto"
        onLoadedData={() => {
          // Try to autoplay when audio is ready
          const audio = document.getElementById('coding-audio') as HTMLAudioElement;
          audio.play().catch(() => {
            console.log('Autoplay blocked - user interaction required');
          });
        }}
      >
        <source src="/audio/no-joy.mp3" type="audio/mpeg" />
        Your browser does not support the audio element.
      </audio>

        {/* Webchella Title */}
            <div className="relative z-10 mb-12 mt-20 sm:mt-16">
              <h2 className="text-[3.5rem] sm:text-[4.5rem] md:text-[5rem] lg:text-[5.5rem] xl:text-[6.5rem] font-bold text-white text-center cursor-pointer transition-all duration-300 group px-4" style={{ 
                fontFamily: 'Inter, -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif', 
                fontWeight: '900', 
                letterSpacing: '-0.02em', 
                lineHeight: '0.8',
                textShadow: '0 2px 4px rgba(0, 0, 0, 0.3), 0 4px 8px rgba(0, 0, 0, 0.2), 0 8px 16px rgba(0, 0, 0, 0.1)',
                filter: 'drop-shadow(0 0 20px rgba(255, 255, 255, 0.1))'
              }}>
                <span 
                  className="inline-block transition-all duration-300" 
                  style={{ 
                    animation: 'balloon 4s ease-in-out infinite',
                    animationDelay: '0s'
                  }}
                >w</span>
                <span 
                  className="inline-block transition-all duration-300" 
                  style={{ 
                    animation: 'balloon 4s ease-in-out infinite',
                    animationDelay: '0.2s'
                  }}
                >e</span>
                <span 
                  className="inline-block transition-all duration-300" 
                  style={{ 
                    animation: 'balloon 4s ease-in-out infinite',
                    animationDelay: '0.4s'
                  }}
                >b</span>
                <span 
                  className="inline-block transition-all duration-300" 
                  style={{ 
                    animation: 'balloon 4s ease-in-out infinite',
                    animationDelay: '0.6s'
                  }}
                >c</span>
                <span 
                  className="inline-block transition-all duration-300" 
                  style={{ 
                    animation: 'balloon 4s ease-in-out infinite',
                    animationDelay: '0.8s'
                  }}
                >h</span>
                <span 
                  className="inline-block transition-all duration-300" 
                  style={{ 
                    animation: 'balloon 4s ease-in-out infinite',
                    animationDelay: '1.0s'
                  }}
                >e</span>
                <span 
                  className="inline-block transition-all duration-300" 
                  style={{ 
                    animation: 'balloon 4s ease-in-out infinite',
                    animationDelay: '1.2s'
                  }}
                >l</span>
                <span 
                  className="inline-block transition-all duration-300" 
                  style={{ 
                    animation: 'balloon 4s ease-in-out infinite',
                    animationDelay: '1.4s'
                  }}
                >l</span>
                <span 
                  className="inline-block transition-all duration-300" 
                  style={{ 
                    animation: 'balloon 4s ease-in-out infinite',
                    animationDelay: '1.6s'
                  }}
                >a</span>
              </h2>
              {/* Slogan subtext */}
              <p className="text-white text-lg sm:text-xl md:text-2xl font-medium text-center mt-4 px-4" style={{
                fontFamily: 'Inter, -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif',
                fontWeight: '500',
                letterSpacing: '-0.01em',
                lineHeight: '1.4',
                textShadow: '0 2px 4px rgba(0, 0, 0, 0.5)',
                filter: 'drop-shadow(0 0 15px rgba(255, 255, 255, 0.2))'
              }}>
                The full-stack lineup you've been waiting for
              </p>
            </div>

            {/* Tech Stack Logos */}
            <div className="relative z-10 mt-8">
              <div className="grid grid-cols-3 sm:grid-cols-4 md:grid-cols-5 lg:grid-cols-6 xl:grid-cols-8 gap-2 sm:gap-3 md:gap-4 px-2 sm:px-4 justify-items-center justify-center">
          <div 
            className="flex items-center justify-center px-3 py-2 sm:px-6 sm:py-4 md:px-8 md:py-6 bg-white/20 backdrop-blur-lg rounded-xl shadow-2xl cursor-pointer transition-all duration-300" 
            style={{ 
              padding: '8px 12px', 
              boxShadow: '0 50px 100px -20px rgba(0, 0, 0, 0.6), 0 25px 50px -12px rgba(0, 0, 0, 0.4), 0 0 0 1px rgba(255, 255, 255, 0.2), inset 0 1px 0 rgba(255, 255, 255, 0.3)',
              backgroundColor: activeLabels.has('tRPC') ? 'rgba(255, 255, 255, 0.1)' : 'rgba(249, 115, 22, 0.6)',
              borderLeft: '4px solid rgba(249, 115, 22, 0.6)',
              borderRight: '2px solid rgba(255, 255, 255, 0.3)',
              borderTop: '6px solid rgba(255, 255, 255, 0.8)',
              borderBottom: '6px solid rgba(255, 255, 255, 0.8)'
            }}
            onMouseEnter={(e) => {
              // No background color change on hover
            }}
            onMouseLeave={(e) => {
              // No background color change on hover
              if (e.currentTarget) {
                e.currentTarget.style.transform = 'scale(1)';
                e.currentTarget.style.transition = 'transform 0.3s cubic-bezier(0.68, -0.55, 0.265, 1.55)';
              }
            }}
            onClick={() => toggleLabel('tRPC')}
            onMouseDown={(e) => {
              if (e.currentTarget) {
                e.currentTarget.style.transform = 'scale(0.95)';
                e.currentTarget.style.transition = 'transform 0.1s ease-out';
              }
            }}
            onMouseUp={(e) => {
              if (e.currentTarget) {
                e.currentTarget.style.transform = 'scale(1.05)';
                setTimeout(() => {
                  if (e.currentTarget) {
                    e.currentTarget.style.transform = 'scale(1)';
                    e.currentTarget.style.transition = 'transform 0.3s cubic-bezier(0.68, -0.55, 0.265, 1.55)';
                  }
                }, 50);
              }
            }}
          >
            <span className="text-white font-bold text-sm sm:text-base md:text-lg drop-shadow-2xl" style={{ fontWeight: 'bold', fontSize: '14px', textShadow: '0 2px 4px rgba(0, 0, 0, 0.5)', fontFamily: 'Inter, -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif' }}>tRPC</span>
          </div>
          <div 
            className="flex items-center justify-center px-3 py-2 sm:px-6 sm:py-4 md:px-8 md:py-6 bg-white/20 backdrop-blur-lg rounded-xl shadow-2xl cursor-pointer transition-all duration-300" 
            style={{ 
              padding: '8px 12px', 
              boxShadow: '0 50px 100px -20px rgba(0, 0, 0, 0.6), 0 25px 50px -12px rgba(0, 0, 0, 0.4), 0 0 0 1px rgba(255, 255, 255, 0.2), inset 0 1px 0 rgba(255, 255, 255, 0.3)',
              backgroundColor: activeLabels.has('Drizzle') ? 'rgba(255, 255, 255, 0.1)' : 'rgba(245, 158, 11, 0.6)',
              borderLeft: '3px solid rgba(245, 158, 11, 0.6)',
              borderRight: '3px solid rgba(245, 158, 11, 0.6)',
              borderTop: '6px solid rgba(255, 255, 255, 0.8)',
              borderBottom: '6px solid rgba(255, 255, 255, 0.8)'
            }}
            onMouseEnter={(e) => {
              // No background color change on hover
            }}
            onMouseLeave={(e) => {
              // No background color change on hover
              if (e.currentTarget) {
                e.currentTarget.style.transform = 'scale(1)';
                e.currentTarget.style.transition = 'transform 0.3s cubic-bezier(0.68, -0.55, 0.265, 1.55)';
              }
            }}
            onClick={() => toggleLabel('Drizzle')}
            onMouseDown={(e) => {
              if (e.currentTarget) {
                e.currentTarget.style.transform = 'scale(0.95)';
                e.currentTarget.style.transition = 'transform 0.1s ease-out';
              }
            }}
            onMouseUp={(e) => {
              if (e.currentTarget) {
                e.currentTarget.style.transform = 'scale(1.05)';
                setTimeout(() => {
                  if (e.currentTarget) {
                    e.currentTarget.style.transform = 'scale(1)';
                    e.currentTarget.style.transition = 'transform 0.3s cubic-bezier(0.68, -0.55, 0.265, 1.55)';
                  }
                }, 50);
              }
            }}
          >
            <span className="text-white font-bold text-sm sm:text-base md:text-lg drop-shadow-2xl" style={{ fontWeight: 'bold', fontSize: '14px', textShadow: '0 2px 4px rgba(0, 0, 0, 0.5)', fontFamily: 'Inter, -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif' }}>Drizzle</span>
          </div>
          <div 
            className="flex items-center justify-center px-3 py-2 sm:px-6 sm:py-4 md:px-8 md:py-6 bg-white/20 backdrop-blur-lg rounded-xl shadow-2xl cursor-pointer transition-all duration-300" 
            style={{ 
              padding: '8px 12px', 
              boxShadow: '0 50px 100px -20px rgba(0, 0, 0, 0.6), 0 25px 50px -12px rgba(0, 0, 0, 0.4), 0 0 0 1px rgba(255, 255, 255, 0.2), inset 0 1px 0 rgba(255, 255, 255, 0.3)',
              backgroundColor: activeLabels.has('TypeScript') ? 'rgba(255, 255, 255, 0.1)' : 'rgba(59, 130, 246, 0.6)',
              borderLeft: '3px solid rgba(59, 130, 246, 0.6)',
              borderRight: '3px solid rgba(59, 130, 246, 0.6)',
              borderTop: '6px solid rgba(255, 255, 255, 0.8)',
              borderBottom: '6px solid rgba(255, 255, 255, 0.8)'
            }}
            onMouseEnter={(e) => {
              // No background color change on hover
            }}
            onMouseLeave={(e) => {
              // No background color change on hover
              if (e.currentTarget) {
                e.currentTarget.style.transform = 'scale(1)';
                e.currentTarget.style.transition = 'transform 0.3s cubic-bezier(0.68, -0.55, 0.265, 1.55)';
              }
            }}
            onClick={() => toggleLabel('TypeScript')}
            onMouseDown={(e) => {
              if (e.currentTarget) {
                e.currentTarget.style.transform = 'scale(0.95)';
                e.currentTarget.style.transition = 'transform 0.1s ease-out';
              }
            }}
            onMouseUp={(e) => {
              if (e.currentTarget) {
                e.currentTarget.style.transform = 'scale(1.05)';
                setTimeout(() => {
                  if (e.currentTarget) {
                    e.currentTarget.style.transform = 'scale(1)';
                    e.currentTarget.style.transition = 'transform 0.3s cubic-bezier(0.68, -0.55, 0.265, 1.55)';
                  }
                }, 50);
              }
            }}
          >
            <span className="text-white font-bold text-sm sm:text-base md:text-lg drop-shadow-2xl" style={{ fontWeight: 'bold', fontSize: '14px', textShadow: '0 2px 4px rgba(0, 0, 0, 0.5)', fontFamily: 'Inter, -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif' }}>TypeScript</span>
        </div>
          <div 
            className="flex items-center justify-center px-3 py-2 sm:px-6 sm:py-4 md:px-8 md:py-6 bg-white/20 backdrop-blur-lg rounded-xl shadow-2xl cursor-pointer transition-all duration-300" 
            style={{ 
              padding: '8px 12px', 
              boxShadow: '0 50px 100px -20px rgba(0, 0, 0, 0.6), 0 25px 50px -12px rgba(0, 0, 0, 0.4), 0 0 0 1px rgba(255, 255, 255, 0.2), inset 0 1px 0 rgba(255, 255, 255, 0.3)',
              backgroundColor: activeLabels.has('Next.js') ? 'rgba(255, 255, 255, 0.1)' : 'rgba(0, 0, 0, 0.6)',
              borderLeft: '3px solid rgba(0, 0, 0, 0.6)',
              borderRight: '3px solid rgba(0, 0, 0, 0.6)',
              borderTop: '6px solid rgba(255, 255, 255, 0.8)',
              borderBottom: '6px solid rgba(255, 255, 255, 0.8)'
            }}
            onMouseEnter={(e) => {
              // No background color change on hover
            }}
            onMouseLeave={(e) => {
              // No background color change on hover
              if (e.currentTarget) {
                e.currentTarget.style.transform = 'scale(1)';
                e.currentTarget.style.transition = 'transform 0.3s cubic-bezier(0.68, -0.55, 0.265, 1.55)';
              }
            }}
            onClick={() => toggleLabel('Next.js')}
            onMouseDown={(e) => {
              if (e.currentTarget) {
                e.currentTarget.style.transform = 'scale(0.95)';
                e.currentTarget.style.transition = 'transform 0.1s ease-out';
              }
            }}
            onMouseUp={(e) => {
              if (e.currentTarget) {
                e.currentTarget.style.transform = 'scale(1.05)';
                setTimeout(() => {
                  if (e.currentTarget) {
                    e.currentTarget.style.transform = 'scale(1)';
                    e.currentTarget.style.transition = 'transform 0.3s cubic-bezier(0.68, -0.55, 0.265, 1.55)';
                  }
                }, 50);
              }
            }}
          >
            <span className="text-white font-bold text-sm sm:text-base md:text-lg drop-shadow-2xl" style={{ fontWeight: 'bold', fontSize: '14px', textShadow: '0 2px 4px rgba(0, 0, 0, 0.5)', fontFamily: 'Inter, -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif' }}>Next.js</span>
          </div>
          <div 
            className="flex items-center justify-center px-3 py-2 sm:px-6 sm:py-4 md:px-8 md:py-6 bg-white/20 backdrop-blur-lg rounded-xl shadow-2xl cursor-pointer transition-all duration-300" 
            style={{ 
              padding: '8px 12px', 
              boxShadow: '0 50px 100px -20px rgba(0, 0, 0, 0.6), 0 25px 50px -12px rgba(0, 0, 0, 0.4), 0 0 0 1px rgba(255, 255, 255, 0.2), inset 0 1px 0 rgba(255, 255, 255, 0.3)',
              backgroundColor: activeLabels.has('Zod') ? 'rgba(255, 255, 255, 0.1)' : 'rgba(147, 51, 234, 0.6)',
              borderLeft: '3px solid rgba(147, 51, 234, 0.6)',
              borderRight: '3px solid rgba(147, 51, 234, 0.6)',
              borderTop: '6px solid rgba(255, 255, 255, 0.8)',
              borderBottom: '6px solid rgba(255, 255, 255, 0.8)'
            }}
            onMouseEnter={(e) => {
              // No background color change on hover
            }}
            onMouseLeave={(e) => {
              // No background color change on hover
              if (e.currentTarget) {
                e.currentTarget.style.transform = 'scale(1)';
                e.currentTarget.style.transition = 'transform 0.3s cubic-bezier(0.68, -0.55, 0.265, 1.55)';
              }
            }}
            onClick={() => toggleLabel('Zod')}
            onMouseDown={(e) => {
              if (e.currentTarget) {
                e.currentTarget.style.transform = 'scale(0.95)';
                e.currentTarget.style.transition = 'transform 0.1s ease-out';
              }
            }}
            onMouseUp={(e) => {
              if (e.currentTarget) {
                e.currentTarget.style.transform = 'scale(1.05)';
                setTimeout(() => {
                  if (e.currentTarget) {
                    e.currentTarget.style.transform = 'scale(1)';
                    e.currentTarget.style.transition = 'transform 0.3s cubic-bezier(0.68, -0.55, 0.265, 1.55)';
                  }
                }, 50);
              }
            }}
          >
            <span className="text-white font-bold text-sm sm:text-base md:text-lg drop-shadow-2xl" style={{ fontWeight: 'bold', fontSize: '14px', textShadow: '0 2px 4px rgba(0, 0, 0, 0.5)', fontFamily: 'Inter, -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif' }}>Zod</span>
        </div>
          <div 
            className="flex items-center justify-center px-3 py-2 sm:px-6 sm:py-4 md:px-8 md:py-6 bg-white/20 backdrop-blur-lg rounded-xl shadow-2xl cursor-pointer transition-all duration-300" 
            style={{ 
              padding: '8px 12px', 
              boxShadow: '0 50px 100px -20px rgba(0, 0, 0, 0.6), 0 25px 50px -12px rgba(0, 0, 0, 0.4), 0 0 0 1px rgba(255, 255, 255, 0.2), inset 0 1px 0 rgba(255, 255, 255, 0.3)',
              backgroundColor: activeLabels.has('React') ? 'rgba(255, 255, 255, 0.1)' : 'rgba(6, 182, 212, 0.6)',
              borderLeft: '3px solid rgba(6, 182, 212, 0.6)',
              borderRight: '3px solid rgba(6, 182, 212, 0.6)',
              borderTop: '6px solid rgba(255, 255, 255, 0.8)',
              borderBottom: '6px solid rgba(255, 255, 255, 0.8)'
            }}
            onMouseEnter={(e) => {
              // No background color change on hover
            }}
            onMouseLeave={(e) => {
              // No background color change on hover
              if (e.currentTarget) {
                e.currentTarget.style.transform = 'scale(1)';
                e.currentTarget.style.transition = 'transform 0.3s cubic-bezier(0.68, -0.55, 0.265, 1.55)';
              }
            }}
            onClick={() => toggleLabel('React')}
            onMouseDown={(e) => {
              if (e.currentTarget) {
                e.currentTarget.style.transform = 'scale(0.95)';
                e.currentTarget.style.transition = 'transform 0.1s ease-out';
              }
            }}
            onMouseUp={(e) => {
              if (e.currentTarget) {
                e.currentTarget.style.transform = 'scale(1.05)';
                setTimeout(() => {
                  if (e.currentTarget) {
                    e.currentTarget.style.transform = 'scale(1)';
                    e.currentTarget.style.transition = 'transform 0.3s cubic-bezier(0.68, -0.55, 0.265, 1.55)';
                  }
                }, 50);
              }
            }}
          >
            <span className="text-white font-bold text-sm sm:text-base md:text-lg drop-shadow-2xl" style={{ fontWeight: 'bold', fontSize: '14px', textShadow: '0 2px 4px rgba(0, 0, 0, 0.5)', fontFamily: 'Inter, -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif' }}>React</span>
                </div>
          <div 
            className="flex items-center justify-center px-3 py-2 sm:px-6 sm:py-4 md:px-8 md:py-6 bg-white/20 backdrop-blur-lg rounded-xl shadow-2xl cursor-pointer transition-all duration-300" 
            style={{ 
              padding: '8px 12px', 
              boxShadow: '0 50px 100px -20px rgba(0, 0, 0, 0.6), 0 25px 50px -12px rgba(0, 0, 0, 0.4), 0 0 0 1px rgba(255, 255, 255, 0.2), inset 0 1px 0 rgba(255, 255, 255, 0.3)',
              backgroundColor: activeLabels.has('Better Auth') ? 'rgba(255, 255, 255, 0.1)' : 'rgba(239, 68, 68, 0.6)',
              borderLeft: '3px solid rgba(239, 68, 68, 0.6)',
              borderRight: '3px solid rgba(239, 68, 68, 0.6)',
              borderTop: '6px solid rgba(255, 255, 255, 0.8)',
              borderBottom: '6px solid rgba(255, 255, 255, 0.8)'
            }}
            onMouseEnter={(e) => {
              // No background color change on hover
            }}
            onMouseLeave={(e) => {
              // No background color change on hover
              if (e.currentTarget) {
                e.currentTarget.style.transform = 'scale(1)';
                e.currentTarget.style.transition = 'transform 0.3s cubic-bezier(0.68, -0.55, 0.265, 1.55)';
              }
            }}
            onClick={() => toggleLabel('Better Auth')}
            onMouseDown={(e) => {
              if (e.currentTarget) {
                e.currentTarget.style.transform = 'scale(0.95)';
                e.currentTarget.style.transition = 'transform 0.1s ease-out';
              }
            }}
            onMouseUp={(e) => {
              if (e.currentTarget) {
                e.currentTarget.style.transform = 'scale(1.05)';
                setTimeout(() => {
                  if (e.currentTarget) {
                    e.currentTarget.style.transform = 'scale(1)';
                    e.currentTarget.style.transition = 'transform 0.3s cubic-bezier(0.68, -0.55, 0.265, 1.55)';
                  }
                }, 50);
              }
            }}
          >
            <span className="text-white font-bold text-sm sm:text-base md:text-lg drop-shadow-2xl" style={{ fontWeight: 'bold', fontSize: '14px', textShadow: '0 2px 4px rgba(0, 0, 0, 0.5)', fontFamily: 'Inter, -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif' }}>Better Auth</span>
                </div>
          <div 
            className="flex items-center justify-center px-3 py-2 sm:px-6 sm:py-4 md:px-8 md:py-6 bg-white/20 backdrop-blur-lg rounded-xl shadow-2xl cursor-pointer transition-all duration-300" 
            style={{ 
              padding: '8px 12px', 
              boxShadow: '0 50px 100px -20px rgba(0, 0, 0, 0.6), 0 25px 50px -12px rgba(0, 0, 0, 0.4), 0 0 0 1px rgba(255, 255, 255, 0.2), inset 0 1px 0 rgba(255, 255, 255, 0.3)',
              backgroundColor: activeLabels.has('Radix') ? 'rgba(255, 255, 255, 0.1)' : 'rgba(34, 197, 94, 0.6)',
              borderLeft: '3px solid rgba(34, 197, 94, 0.6)',
              borderRight: '3px solid rgba(34, 197, 94, 0.6)',
              borderTop: '6px solid rgba(255, 255, 255, 0.8)',
              borderBottom: '6px solid rgba(255, 255, 255, 0.8)'
            }}
            onMouseEnter={(e) => {
              // No background color change on hover
            }}
            onMouseLeave={(e) => {
              // No background color change on hover
              if (e.currentTarget) {
                e.currentTarget.style.transform = 'scale(1)';
                e.currentTarget.style.transition = 'transform 0.3s cubic-bezier(0.68, -0.55, 0.265, 1.55)';
              }
            }}
            onClick={() => toggleLabel('Radix')}
            onMouseDown={(e) => {
              if (e.currentTarget) {
                e.currentTarget.style.transform = 'scale(0.95)';
                e.currentTarget.style.transition = 'transform 0.1s ease-out';
              }
            }}
            onMouseUp={(e) => {
              if (e.currentTarget) {
                e.currentTarget.style.transform = 'scale(1.05)';
                setTimeout(() => {
                  if (e.currentTarget) {
                    e.currentTarget.style.transform = 'scale(1)';
                    e.currentTarget.style.transition = 'transform 0.3s cubic-bezier(0.68, -0.55, 0.265, 1.55)';
                  }
                }, 50);
              }
            }}
          >
            <span className="text-white font-bold text-sm sm:text-base md:text-lg drop-shadow-2xl" style={{ fontWeight: 'bold', fontSize: '14px', textShadow: '0 2px 4px rgba(0, 0, 0, 0.5)', fontFamily: 'Inter, -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif' }}>Radix</span>
                    </div>
          <div 
            className="flex items-center justify-center px-3 py-2 sm:px-6 sm:py-4 md:px-8 md:py-6 bg-white/20 backdrop-blur-lg rounded-xl shadow-2xl cursor-pointer transition-all duration-300" 
            style={{ 
              padding: '8px 12px', 
              boxShadow: '0 50px 100px -20px rgba(0, 0, 0, 0.6), 0 25px 50px -12px rgba(0, 0, 0, 0.4), 0 0 0 1px rgba(255, 255, 255, 0.2), inset 0 1px 0 rgba(255, 255, 255, 0.3)',
              backgroundColor: activeLabels.has('Tailwind') ? 'rgba(255, 255, 255, 0.1)' : 'rgba(20, 184, 166, 0.6)',
              borderLeft: '2px solid rgba(20, 184, 166, 0.3)',
              borderRight: '4px solid rgba(20, 184, 166, 0.6)',
              borderTop: '6px solid rgba(255, 255, 255, 0.8)',
              borderBottom: '6px solid rgba(255, 255, 255, 0.8)'
            }}
            onMouseEnter={(e) => {
              // No background color change on hover
            }}
            onMouseLeave={(e) => {
              // No background color change on hover
              if (e.currentTarget) {
                e.currentTarget.style.transform = 'scale(1)';
                e.currentTarget.style.transition = 'transform 0.3s cubic-bezier(0.68, -0.55, 0.265, 1.55)';
              }
            }}
            onClick={() => toggleLabel('Tailwind')}
            onMouseDown={(e) => {
              if (e.currentTarget) {
                e.currentTarget.style.transform = 'scale(0.95)';
                e.currentTarget.style.transition = 'transform 0.1s ease-out';
              }
            }}
            onMouseUp={(e) => {
              if (e.currentTarget) {
                e.currentTarget.style.transform = 'scale(1.05)';
                setTimeout(() => {
                  if (e.currentTarget) {
                    e.currentTarget.style.transform = 'scale(1)';
                    e.currentTarget.style.transition = 'transform 0.3s cubic-bezier(0.68, -0.55, 0.265, 1.55)';
                  }
                }, 50);
              }
            }}
          >
            <span className="text-white font-bold text-sm sm:text-base md:text-lg drop-shadow-2xl" style={{ fontWeight: 'bold', fontSize: '14px', textShadow: '0 2px 4px rgba(0, 0, 0, 0.5)', fontFamily: 'Inter, -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif' }}>Tailwind</span>
                  </div>
                  <div 
                    className="flex items-center justify-center px-3 py-2 sm:px-6 sm:py-4 md:px-8 md:py-6 bg-white/20 backdrop-blur-lg rounded-xl shadow-2xl cursor-pointer transition-all duration-300" 
                    style={{ 
                      padding: '8px 12px', 
                      boxShadow: '0 50px 100px -20px rgba(0, 0, 0, 0.6), 0 25px 50px -12px rgba(0, 0, 0, 0.4), 0 0 0 1px rgba(255, 255, 255, 0.2), inset 0 1px 0 rgba(255, 255, 255, 0.3)',
                      backgroundColor: activeLabels.has('AI SDK') ? 'rgba(255, 255, 255, 0.1)' : 'rgba(59, 130, 246, 0.6)',
                      borderLeft: '3px solid rgba(59, 130, 246, 0.6)',
                      borderRight: '3px solid rgba(59, 130, 246, 0.6)',
                      borderTop: '6px solid rgba(255, 255, 255, 0.8)',
                      borderBottom: '6px solid rgba(255, 255, 255, 0.8)'
                    }}
                    onClick={() => toggleLabel('AI SDK')}
                    onMouseDown={(e) => {
                      if (e.currentTarget) {
                        e.currentTarget.style.transform = 'scale(0.95)';
                        e.currentTarget.style.transition = 'transform 0.1s ease-out';
                      }
                    }}
                    onMouseUp={(e) => {
                      if (e.currentTarget) {
                        e.currentTarget.style.transform = 'scale(1.05)';
                        setTimeout(() => {
                          if (e.currentTarget) {
                            e.currentTarget.style.transform = 'scale(1)';
                            e.currentTarget.style.transition = 'transform 0.3s cubic-bezier(0.68, -0.55, 0.265, 1.55)';
                          }
                        }, 50);
                      }
                    }}
                  >
                    <span className="text-white font-bold text-sm sm:text-base md:text-lg drop-shadow-2xl" style={{ fontWeight: 'bold', fontSize: '14px', textShadow: '0 2px 4px rgba(0, 0, 0, 0.5)', fontFamily: 'Inter, -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif' }}>AI SDK</span>
                  </div>
                  <div 
                    className="flex items-center justify-center px-3 py-2 sm:px-6 sm:py-4 md:px-8 md:py-6 bg-white/20 backdrop-blur-lg rounded-xl shadow-2xl cursor-pointer transition-all duration-300" 
                    style={{ 
                      padding: '8px 12px', 
                      boxShadow: '0 50px 100px -20px rgba(0, 0, 0, 0.6), 0 25px 50px -12px rgba(0, 0, 0, 0.4), 0 0 0 1px rgba(255, 255, 255, 0.2), inset 0 1px 0 rgba(255, 255, 255, 0.3)',
                      backgroundColor: activeLabels.has('Stripe') ? 'rgba(255, 255, 255, 0.1)' : 'rgba(100, 37, 255, 0.6)',
                      borderLeft: '3px solid rgba(100, 37, 255, 0.6)',
                      borderRight: '3px solid rgba(100, 37, 255, 0.6)',
                      borderTop: '6px solid rgba(255, 255, 255, 0.8)',
                      borderBottom: '6px solid rgba(255, 255, 255, 0.8)'
                    }}
                    onClick={() => toggleLabel('Stripe')}
                    onMouseDown={(e) => {
                      if (e.currentTarget) {
                        e.currentTarget.style.transform = 'scale(0.95)';
                        e.currentTarget.style.transition = 'transform 0.1s ease-out';
                      }
                    }}
                    onMouseUp={(e) => {
                      if (e.currentTarget) {
                        e.currentTarget.style.transform = 'scale(1.05)';
                        setTimeout(() => {
                          if (e.currentTarget) {
                            e.currentTarget.style.transform = 'scale(1)';
                            e.currentTarget.style.transition = 'transform 0.3s cubic-bezier(0.68, -0.55, 0.265, 1.55)';
                          }
                        }, 50);
                      }
                    }}
                  >
                    <span className="text-white font-bold text-sm sm:text-base md:text-lg drop-shadow-2xl" style={{ fontWeight: 'bold', fontSize: '14px', textShadow: '0 2px 4px rgba(0, 0, 0, 0.5)', fontFamily: 'Inter, -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif' }}>Stripe</span>
                  </div>
                  <div 
                    className="flex items-center justify-center px-3 py-2 sm:px-6 sm:py-4 md:px-8 md:py-6 bg-white/20 backdrop-blur-lg rounded-xl shadow-2xl cursor-pointer transition-all duration-300" 
                    style={{ 
                      padding: '8px 12px', 
                      boxShadow: '0 50px 100px -20px rgba(0, 0, 0, 0.6), 0 25px 50px -12px rgba(0, 0, 0, 0.4), 0 0 0 1px rgba(255, 255, 255, 0.2), inset 0 1px 0 rgba(255, 255, 255, 0.3)',
                      backgroundColor: activeLabels.has('Resend') ? 'rgba(255, 255, 255, 0.1)' : 'rgba(255, 99, 71, 0.6)',
                      borderLeft: '3px solid rgba(255, 99, 71, 0.6)',
                      borderRight: '3px solid rgba(255, 99, 71, 0.6)',
                      borderTop: '6px solid rgba(255, 255, 255, 0.8)',
                      borderBottom: '6px solid rgba(255, 255, 255, 0.8)'
                    }}
                    onClick={() => toggleLabel('Resend')}
                    onMouseDown={(e) => {
                      if (e.currentTarget) {
                        e.currentTarget.style.transform = 'scale(0.95)';
                        e.currentTarget.style.transition = 'transform 0.1s ease-out';
                      }
                    }}
                    onMouseUp={(e) => {
                      if (e.currentTarget) {
                        e.currentTarget.style.transform = 'scale(1.05)';
                        setTimeout(() => {
                          if (e.currentTarget) {
                            e.currentTarget.style.transform = 'scale(1)';
                            e.currentTarget.style.transition = 'transform 0.3s cubic-bezier(0.68, -0.55, 0.265, 1.55)';
                          }
                        }, 50);
                      }
                    }}
                  >
                    <span className="text-white font-bold text-sm sm:text-base md:text-lg drop-shadow-2xl" style={{ fontWeight: 'bold', fontSize: '14px', textShadow: '0 2px 4px rgba(0, 0, 0, 0.5)', fontFamily: 'Inter, -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif' }}>Resend</span>
                  </div>
                  <div 
                    className="flex items-center justify-center px-3 py-2 sm:px-6 sm:py-4 md:px-8 md:py-6 bg-white/20 backdrop-blur-lg rounded-xl shadow-2xl cursor-pointer transition-all duration-300" 
                    style={{ 
                      padding: '8px 12px', 
                      boxShadow: '0 50px 100px -20px rgba(0, 0, 0, 0.6), 0 25px 50px -12px rgba(0, 0, 0, 0.4), 0 0 0 1px rgba(255, 255, 255, 0.2), inset 0 1px 0 rgba(255, 255, 255, 0.3)',
                      backgroundColor: activeLabels.has('trigger.dev') ? 'rgba(255, 255, 255, 0.1)' : 'rgba(139, 69, 19, 0.6)',
                      borderLeft: '3px solid rgba(139, 69, 19, 0.6)',
                      borderRight: '3px solid rgba(139, 69, 19, 0.6)',
                      borderTop: '6px solid rgba(255, 255, 255, 0.8)',
                      borderBottom: '6px solid rgba(255, 255, 255, 0.8)'
                    }}
                    onClick={() => toggleLabel('trigger.dev')}
                    onMouseDown={(e) => {
                      if (e.currentTarget) {
                        e.currentTarget.style.transform = 'scale(0.95)';
                        e.currentTarget.style.transition = 'transform 0.1s ease-out';
                      }
                    }}
                    onMouseUp={(e) => {
                      if (e.currentTarget) {
                        e.currentTarget.style.transform = 'scale(1.05)';
                        setTimeout(() => {
                          if (e.currentTarget) {
                            e.currentTarget.style.transform = 'scale(1)';
                            e.currentTarget.style.transition = 'transform 0.3s cubic-bezier(0.68, -0.55, 0.265, 1.55)';
                          }
                        }, 50);
                      }
                    }}
                  >
                    <span className="text-white font-bold text-sm sm:text-base md:text-lg drop-shadow-2xl" style={{ fontWeight: 'bold', fontSize: '14px', textShadow: '0 2px 4px rgba(0, 0, 0, 0.5)', fontFamily: 'Inter, -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif' }}>trigger.dev</span>
                  </div>
                  <div 
                    className="flex items-center justify-center px-3 py-2 sm:px-6 sm:py-4 md:px-8 md:py-6 bg-white/20 backdrop-blur-lg rounded-xl shadow-2xl cursor-pointer transition-all duration-300" 
                    style={{ 
                      padding: '8px 12px', 
                      boxShadow: '0 50px 100px -20px rgba(0, 0, 0, 0.6), 0 25px 50px -12px rgba(0, 0, 0, 0.4), 0 0 0 1px rgba(255, 255, 255, 0.2), inset 0 1px 0 rgba(255, 255, 255, 0.3)',
                      backgroundColor: activeLabels.has('Supabase') ? 'rgba(255, 255, 255, 0.1)' : 'rgba(62, 207, 142, 0.6)',
                      borderLeft: '3px solid rgba(62, 207, 142, 0.6)',
                      borderRight: '3px solid rgba(62, 207, 142, 0.6)',
                      borderTop: '6px solid rgba(255, 255, 255, 0.8)',
                      borderBottom: '6px solid rgba(255, 255, 255, 0.8)'
                    }}
                    onClick={() => toggleLabel('Supabase')}
                    onMouseDown={(e) => {
                      if (e.currentTarget) {
                        e.currentTarget.style.transform = 'scale(0.95)';
                        e.currentTarget.style.transition = 'transform 0.1s ease-out';
                      }
                    }}
                    onMouseUp={(e) => {
                      if (e.currentTarget) {
                        e.currentTarget.style.transform = 'scale(1.05)';
                        setTimeout(() => {
                          if (e.currentTarget) {
                            e.currentTarget.style.transform = 'scale(1)';
                            e.currentTarget.style.transition = 'transform 0.3s cubic-bezier(0.68, -0.55, 0.265, 1.55)';
                          }
                        }, 50);
                      }
                    }}
                  >
                    <span className="text-white font-bold text-sm sm:text-base md:text-lg drop-shadow-2xl" style={{ fontWeight: 'bold', fontSize: '14px', textShadow: '0 2px 4px rgba(0, 0, 0, 0.5)', fontFamily: 'Inter, -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif' }}>Supabase</span>
                  </div>
                  <div 
                    className="flex items-center justify-center px-3 py-2 sm:px-6 sm:py-4 md:px-8 md:py-6 bg-white/20 backdrop-blur-lg rounded-xl shadow-2xl cursor-pointer transition-all duration-300" 
                    style={{ 
                      padding: '8px 12px', 
                      boxShadow: '0 50px 100px -20px rgba(0, 0, 0, 0.6), 0 25px 50px -12px rgba(0, 0, 0, 0.4), 0 0 0 1px rgba(255, 255, 255, 0.2), inset 0 1px 0 rgba(255, 255, 255, 0.3)',
                      backgroundColor: activeLabels.has('Pino') ? 'rgba(255, 255, 255, 0.1)' : 'rgba(255, 193, 7, 0.6)',
                      borderLeft: '3px solid rgba(255, 193, 7, 0.6)',
                      borderRight: '3px solid rgba(255, 193, 7, 0.6)',
                      borderTop: '6px solid rgba(255, 255, 255, 0.8)',
                      borderBottom: '6px solid rgba(255, 255, 255, 0.8)'
                    }}
                    onClick={() => toggleLabel('Pino')}
                    onMouseDown={(e) => {
                      if (e.currentTarget) {
                        e.currentTarget.style.transform = 'scale(0.95)';
                        e.currentTarget.style.transition = 'transform 0.1s ease-out';
                      }
                    }}
                    onMouseUp={(e) => {
                      if (e.currentTarget) {
                        e.currentTarget.style.transform = 'scale(1.05)';
                        setTimeout(() => {
                          if (e.currentTarget) {
                            e.currentTarget.style.transform = 'scale(1)';
                            e.currentTarget.style.transition = 'transform 0.3s cubic-bezier(0.68, -0.55, 0.265, 1.55)';
                          }
                        }, 50);
                      }
                    }}
                  >
                    <span className="text-white font-bold text-sm sm:text-base md:text-lg drop-shadow-2xl" style={{ fontWeight: 'bold', fontSize: '14px', textShadow: '0 2px 4px rgba(0, 0, 0, 0.5)', fontFamily: 'Inter, -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif' }}>Pino</span>
                  </div>
                </div>
              </div>
                      {/* Big Down Arrow Button */}
        <div className="flex justify-center mb-4 mt-16">
          <button
            onClick={() => {
              const nextSection = document.getElementById('onboarding-section');
              if (nextSection) {
                nextSection.scrollIntoView({ behavior: 'smooth', block: 'start' });
              }
            }}
            className="group bg-black/40 hover:bg-black/60 backdrop-blur-lg transition-all duration-300 hover:scale-110 hover:shadow-2xl animate-bounce cursor-pointer relative"
            style={{
              boxShadow: '0 8px 32px rgba(0, 0, 0, 0.2)',
              width: '64px',
              height: '64px',
              borderRadius: '50%',
              display: 'flex',
              alignItems: 'center',
              justifyContent: 'center',
              cursor: 'pointer',
              animation: 'bounce 2s ease-in-out infinite',
              transformOrigin: 'center',
              border: '2px solid transparent',
              backgroundImage: 'linear-gradient(45deg, #ff6b6b, #4ecdc4, #45b7d1, #96ceb4, #feca57, #ff9ff3, #54a0ff), linear-gradient(45deg, rgba(0,0,0,0.4), rgba(0,0,0,0.4))',
              backgroundOrigin: 'border-box',
              backgroundClip: 'padding-box, border-box'
            }}
          >
            <div className="text-white text-4xl font-bold group-hover:scale-125 transition-transform duration-300" style={{ 
              fontSize: '2rem',
              fontWeight: '400',
              textShadow: '0 2px 4px rgba(0, 0, 0, 0.5)'
            }}>↓</div>
          </button>
        </div>
            </div>

      {/* Onboarding Section */}
      <div id="onboarding-section" className="relative z-10 min-h-screen bg-gradient-to-b from-transparent via-white/5 to-white/10 py-8 md:py-12 px-4 flex flex-col items-center justify-center">
        {/* Introduction Text */}
        <div className="text-center max-w-3xl px-4 mb-8 md:mb-12 mt-20 sm:mt-16">
          <div className="backdrop-blur-md rounded-3xl px-4 py-3 relative" style={{
            background: 'linear-gradient(135deg, rgba(0,0,0,0.95) 0%, rgba(20,20,20,0.9) 100%)',
            opacity: 0.95
          }}>
            {/* Rainbow gradient border using pseudo-element */}
            <div className="absolute inset-0 rounded-3xl p-1" style={{
              background: 'linear-gradient(45deg, #ff6b6b, #4ecdc4, #45b7d1, #96ceb4, #feca57, #ff9ff3, #54a0ff)',
              zIndex: -1
            }}>
              <div className="w-full h-full rounded-3xl" style={{
                background: 'linear-gradient(135deg, rgba(0,0,0,0.95) 0%, rgba(20,20,20,0.9) 100%)'
              }}></div>
            </div>
            <p className="text-white text-sm md:text-base lg:text-lg drop-shadow-[0_4px_12px_rgba(0,0,0,0.8)] leading-relaxed">
              Your webchella kit includes a <span className="font-semibold text-white">Fullstack Agent</span> and <span className="font-semibold text-white">PM Agent</span> to guide your development, along with <span className="font-semibold text-white">Code Quality Cursor Rules</span> for consistent success.
            </p>
          </div>
        </div>
        
        <div className="w-full max-w-4xl mx-auto flex items-center justify-center flex-1">
          <Card className="backdrop-blur-2xl shadow-2xl w-full h-full min-h-[500px] md:min-h-[550px] flex flex-col rounded-3xl relative" style={{
            background: 'linear-gradient(135deg, rgba(0,0,0,0.95) 0%, rgba(15,15,15,0.9) 100%)',
            opacity: 0.95
          }}>
            {/* Rainbow gradient border using pseudo-element */}
            <div className="absolute inset-0 rounded-3xl p-1" style={{
              background: 'linear-gradient(45deg, #ff6b6b, #4ecdc4, #45b7d1, #96ceb4, #feca57, #ff9ff3, #54a0ff)',
              zIndex: -1
            }}>
              <div className="w-full h-full rounded-3xl" style={{
                background: 'linear-gradient(135deg, rgba(0,0,0,0.95) 0%, rgba(15,15,15,0.9) 100%)'
              }}></div>
            </div>
            <CardHeader className="text-center">
              <p className="text-white/60 font-medium text-xs md:text-sm tracking-widest uppercase mb-6">
                Step {currentStep + 1} of {onboardingSteps.length}
              </p>
              <CardTitle className="text-white drop-shadow-lg text-2xl md:text-3xl lg:text-4xl font-bold px-2 mb-3">
                {onboardingSteps[currentStep].title}
              </CardTitle>
              <CardDescription className="text-white/90 text-base md:text-lg lg:text-xl px-2 leading-relaxed">
                {onboardingSteps[currentStep].description}
              </CardDescription>
            </CardHeader>
            <CardContent className="flex-1 flex flex-col py-4 px-3 md:px-4">
              {/* Content Area - Takes available space */}
              <div className="flex-1 flex items-center justify-center">
                <div className="space-y-6 w-full">
                  {/* Logo Display */}
                  {onboardingSteps[currentStep].logo && (
                    <div className="flex justify-center">
                      <div className="bg-white/10 backdrop-blur-sm rounded-lg p-4 border border-white/20 hover:border-white/30 transition-all duration-300 shadow-lg">
                        <img 
                          src={onboardingSteps[currentStep].logo} 
                          alt="Service logo"
                          className="h-12 md:h-16 w-auto object-contain"
                        />
                      </div>
                    </div>
                  )}

                  {/* Command Display for Step 1 */}
                  {currentStep === 0 && onboardingSteps[currentStep].command && (
                    <div className="bg-black/60 backdrop-blur-sm rounded-lg p-2 md:p-3 border border-white/30 shadow-lg">
                      <div className="flex items-center gap-2 mb-1">
                        <span className="text-white font-medium text-xs font-mono tracking-wider">TERMINAL</span>
                      </div>
                      <div 
                        className="font-mono text-xs bg-black/60 rounded-lg p-2 md:p-3 cursor-pointer hover:bg-black/80 transition-all duration-200 hover:border-green-400/50 border border-white/20 overflow-x-auto shadow-inner"
                        onClick={async () => {
                          await navigator.clipboard.writeText(onboardingSteps[currentStep].command || '');
                          setCopied(true);
                          setTimeout(() => setCopied(false), 2000);
                        }}
                        title="Click to copy"
                      >
                        <span className="text-green-400 font-semibold">$</span>{' '}
                        <span className="text-white font-medium whitespace-nowrap">{onboardingSteps[currentStep].command}</span>
                      </div>
                      <p className={`font-medium text-xs mt-1 flex items-center gap-1.5 transition-colors duration-300 ${copied ? 'text-green-400' : 'text-green-400/70'}`}>
                        {copied ? (
                          <>
                            <Check className="w-4 h-4 animate-bounce" />
                            <span>Copied!</span>
                          </>
                        ) : (
                          <>
                            <Copy className="w-3.5 h-3.5" />
                            <span>Click to copy</span>
                          </>
                        )}
                      </p>
                    </div>
                  )}

                  {/* Action Button */}
                  <div className="flex justify-center mb-6">
                    {currentStep === onboardingSteps.length - 1 ? (
                      <a
                        href="https://twitter.com/intent/tweet?text=I'm%20shipping%20with%20webchella!%20Check%20it%20out%20at%20webchella.dev%20🚀"
                        target="_blank"
                        rel="noopener noreferrer"
                        className="relative inline-flex items-center justify-center w-24 h-24 md:w-32 md:h-32 rounded-full transition-all duration-300 hover:scale-110 cursor-pointer"
                      >
                        {/* Disco ball gradient background */}
                        <div 
                          className="absolute inset-0 rounded-full opacity-80 group-hover:opacity-100 transition-opacity duration-300"
                          style={{
                            background: 'radial-gradient(circle at center, #ff6b6b, #ffa94d, #ffd93d, #6bcf7f, #4dabf7, #9775fa, #f783ac)',
                            backgroundSize: '400% 400%',
                            animation: 'discoRotate 8s ease infinite',
                          }}
                        />
                        {/* Overlay for depth */}
                        <div className="absolute inset-[2px] rounded-full bg-gradient-to-br from-white/20 to-transparent" />
                        {/* Inner shadow */}
                        <div className="absolute inset-[4px] rounded-full bg-gradient-to-tr from-black/20 to-transparent" />
                        {/* Text with better contrast - always filled */}
                        <span className="relative z-10 text-white font-bold text-xl md:text-2xl tracking-tight drop-shadow-[0_2px_4px_rgba(0,0,0,0.5)] [!color:white!important]" style={{ WebkitTextStroke: '0px' }}>
                          SHIP
                        </span>
                        
                        <style jsx>{`
                          @keyframes discoRotate {
                            0%, 100% {
                              background-position: 0% 0%;
                            }
                            25% {
                              background-position: 100% 0%;
                            }
                            50% {
                              background-position: 100% 100%;
                            }
                            75% {
                              background-position: 0% 100%;
                            }
                          }
                        `}</style>
                      </a>
                    ) : (
                      <a
                        href={onboardingSteps[currentStep].link}
                        target="_blank"
                        rel="noopener noreferrer"
                        className="inline-flex items-center justify-center px-6 py-3 rounded-lg bg-white/10 hover:bg-white/20 backdrop-blur-sm border border-white/30 hover:border-white/50 text-white font-medium text-sm md:text-base transition-all duration-300 hover:scale-105 cursor-pointer"
                      >
                        {onboardingSteps[currentStep].cta}
                      </a>
                    )}
                  </div>
                </div>
              </div>

              {/* Carousel Navigation - Fixed at bottom */}
              <div className="mt-auto pt-4 px-2 border-t border-white/20">
                {/* Mobile Layout - Stacked */}
                <div className="flex flex-col gap-4 sm:hidden">
                  {/* Dots Indicator - Full width on mobile */}
                  <div className="flex justify-center">
                    <div className="flex gap-2 bg-white/5 rounded-full p-1 backdrop-blur-sm border border-white/10">
                      {onboardingSteps.map((_, index) => (
                        <button
                          key={index}
                          onClick={() => setCurrentStep(index)}
                          className={`rounded-full transition-all duration-300 cursor-pointer ${
                            index === currentStep
                              ? 'w-6 h-2 bg-white shadow-lg'
                              : 'w-2 h-2 bg-white/40 hover:bg-white/60'
                          }`}
                          aria-label={`Go to step ${index + 1}`}
                        />
                      ))}
                    </div>
                  </div>
                  
                  {/* Buttons - Full width on mobile */}
                  <div className="flex gap-3">
                    <button
                      onClick={() => setCurrentStep(Math.max(0, currentStep - 1))}
                      disabled={currentStep === 0}
                      className="flex-1 bg-white/10 hover:bg-white/20 backdrop-blur-sm border border-white/20 hover:border-white/40 px-4 py-3 rounded-lg text-white font-medium text-sm transition-all duration-200 disabled:opacity-20 disabled:cursor-not-allowed cursor-pointer disabled:hover:bg-white/10"
                    >
                      ← Previous
                    </button>
                    <button
                      onClick={() => setCurrentStep(Math.min(onboardingSteps.length - 1, currentStep + 1))}
                      disabled={currentStep === onboardingSteps.length - 1}
                      className="flex-1 bg-white/10 hover:bg-white/20 backdrop-blur-sm border border-white/20 hover:border-white/40 px-4 py-3 rounded-lg text-white font-medium text-sm transition-all duration-200 disabled:opacity-20 disabled:cursor-not-allowed cursor-pointer disabled:hover:bg-white/10"
                    >
                      Next →
                    </button>
                  </div>
                </div>

                {/* Desktop Layout - Horizontal */}
                <div className="hidden sm:flex items-center justify-between">
                  <button
                    onClick={() => setCurrentStep(Math.max(0, currentStep - 1))}
                    disabled={currentStep === 0}
                    className="bg-white/10 hover:bg-white/20 backdrop-blur-sm border border-white/20 hover:border-white/40 px-4 py-2 rounded-lg text-white font-medium text-sm md:text-base transition-all duration-200 disabled:opacity-20 disabled:cursor-not-allowed cursor-pointer disabled:hover:bg-white/10"
                  >
                    ← Previous
                  </button>

                  {/* Dots Indicator */}
                  <div className="flex gap-2 bg-white/5 rounded-full p-1 backdrop-blur-sm border border-white/10">
                    {onboardingSteps.map((_, index) => (
                      <button
                        key={index}
                        onClick={() => setCurrentStep(index)}
                        className={`rounded-full transition-all duration-300 cursor-pointer ${
                          index === currentStep
                            ? 'w-8 h-2 bg-white shadow-lg'
                            : 'w-2 h-2 bg-white/40 hover:bg-white/60'
                        }`}
                        aria-label={`Go to step ${index + 1}`}
                      />
                    ))}
                  </div>

                  <button
                    onClick={() => setCurrentStep(Math.min(onboardingSteps.length - 1, currentStep + 1))}
                    disabled={currentStep === onboardingSteps.length - 1}
                    className="bg-white/10 hover:bg-white/20 backdrop-blur-sm border border-white/20 hover:border-white/40 px-4 py-2 rounded-lg text-white font-medium text-sm md:text-base transition-all duration-200 disabled:opacity-20 disabled:cursor-not-allowed cursor-pointer disabled:hover:bg-white/10"
                  >
                    Next →
                  </button>
                </div>
              </div>
            </CardContent>
          </Card>
        </div>
      </div>

      {/* Footer */}
      <footer className="relative z-10 mt-16 bg-black/95 backdrop-blur-lg transition-opacity duration-500" style={{ borderTop: '4px solid', borderImage: 'linear-gradient(90deg, #ff6b6b, #4ecdc4, #45b7d1, #96ceb4, #feca57, #ff9ff3) 1' }}>
        <div className="container mx-auto px-4 py-6">
          <div className="text-center">
            <p className="text-white/80 text-sm">
              Created with 💛 by{' '}
              <a 
                href="https://x.com/coookiecrisp97" 
                target="_blank" 
                rel="noopener noreferrer"
                className="text-white hover:text-blue-400 transition-colors duration-200 font-medium"
              >
                @coookiecrisp97
              </a>
            </p>
          </div>
        </div>
      </footer>
    </main>
  );
}

function Sky() {
  const ref = useRef<THREE.Group>(null);
  const cloud0 = useRef<THREE.Group>(null);
  const [colors, setColors] = useState({ primary: "#ff8c42", secondary: "#d2691e", accent: "#ff6b35" });
  
  // Fixed cloud configuration for full-screen coverage
  const config = {
    seed: 1,
    segments: 20,
    volume: 20,
    opacity: 0.8,
    fade: 10,
    growth: 4,
    speed: 0.02, // Much slower movement
  };

  const bounds: [number, number, number] = [20, 10, 20]; // x, y, z bounds

  useFrame((state, delta) => {
    // Color cycling for elegant transitions
    const time = state.clock.elapsedTime;
    const colorCycle = Math.sin(time * 0.1) * 0.5 + 0.5; // 0 to 1 over time
    
    // Define color palettes for different moods
    const colorPalettes = [
      // Stormy grays
      { primary: "#8B7D8B", secondary: "#A9A9A9", accent: "#696969" },
      // Bright morning
      { primary: "#FFB6C1", secondary: "#FFA07A", accent: "#FFD700" },
      // Deep purples
      { primary: "#9370DB", secondary: "#8A2BE2", accent: "#4B0082" },
      // Stormy reds
      { primary: "#CD5C5C", secondary: "#B22222", accent: "#8B0000" },
      // Soft blues
      { primary: "#87CEEB", secondary: "#4682B4", accent: "#1E90FF" }
    ];
    
    // Interpolate between color palettes
    const paletteIndex = Math.floor(colorCycle * (colorPalettes.length - 1));
    const nextPaletteIndex = (paletteIndex + 1) % colorPalettes.length;
    const blendFactor = (colorCycle * (colorPalettes.length - 1)) % 1;
    
    const currentPalette = colorPalettes[paletteIndex];
    const nextPalette = colorPalettes[nextPaletteIndex];
    
    // Blend colors smoothly
    const blendColor = (color1: string, color2: string, factor: number) => {
      const hex1 = color1.replace('#', '');
      const hex2 = color2.replace('#', '');
      const r1 = parseInt(hex1.substr(0, 2), 16);
      const g1 = parseInt(hex1.substr(2, 2), 16);
      const b1 = parseInt(hex1.substr(4, 2), 16);
      const r2 = parseInt(hex2.substr(0, 2), 16);
      const g2 = parseInt(hex2.substr(2, 2), 16);
      const b2 = parseInt(hex2.substr(4, 2), 16);
      
      const r = Math.round(r1 + (r2 - r1) * factor);
      const g = Math.round(g1 + (g2 - g1) * factor);
      const b = Math.round(b1 + (b2 - b1) * factor);
      
      return `#${r.toString(16).padStart(2, '0')}${g.toString(16).padStart(2, '0')}${b.toString(16).padStart(2, '0')}`;
    };
    
    const primaryColor = blendColor(currentPalette.primary, nextPalette.primary, blendFactor);
    const secondaryColor = blendColor(currentPalette.secondary, nextPalette.secondary, blendFactor);
    const accentColor = blendColor(currentPalette.accent, nextPalette.accent, blendFactor);
    
    // Update colors state
    setColors({ primary: primaryColor, secondary: secondaryColor, accent: accentColor });
    if (ref.current) {
      ref.current.rotation.y = Math.cos(state.clock.elapsedTime / 8) / 4; // Much slower rotation
      ref.current.rotation.x = Math.sin(state.clock.elapsedTime / 8) / 4;
    }
    if (cloud0.current) {
      cloud0.current.rotation.y -= delta * 0.1; // Much slower cloud rotation
    }
  });
  
  return (
    <>
      <SkyImpl />
      <group ref={ref}>
        <Clouds material={THREE.MeshLambertMaterial} limit={800}>
          <Cloud ref={cloud0} {...config} bounds={bounds} color={colors.primary} />
          <Cloud {...config} bounds={bounds} color={colors.secondary} seed={2} position={[30, 0, 0]} />
          <Cloud {...config} bounds={bounds} color={colors.accent} seed={3} position={[-30, 0, 0]} />
          <Cloud {...config} bounds={bounds} color={colors.primary} seed={4} position={[0, 0, -25]} />
          <Cloud {...config} bounds={bounds} color={colors.secondary} seed={5} position={[0, 0, 25]} />
          <Cloud {...config} bounds={bounds} color={colors.accent} seed={6} position={[20, 5, 10]} />
          <Cloud {...config} bounds={bounds} color={colors.primary} seed={7} position={[-20, -5, -10]} />
          <Cloud concentrate="outside" growth={100} color={colors.accent} opacity={1.25} seed={0.3} bounds={200} volume={200} />
        </Clouds>
      </group>
    </>
  );
}

