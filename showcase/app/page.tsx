"use client";

import * as THREE from "three";
import { useRef, useState, useEffect } from "react";
import { Canvas, useFrame } from "@react-three/fiber";
import { Clouds, Cloud, CameraControls, Sky as SkyImpl } from "@react-three/drei";
import { Coffee, Play, Pause } from "lucide-react";

export default function Home() {
  const [activeLabels, setActiveLabels] = useState<Set<string>>(new Set());
  const [buttonSize, setButtonSize] = useState('120px');

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
        setButtonSize('480px');
      } else if (width >= 1280) { // xl
        setButtonSize('400px');
      } else if (width >= 1024) { // lg
        setButtonSize('320px');
      } else if (width >= 768) { // md
        setButtonSize('240px');
      } else if (width >= 640) { // sm
        setButtonSize('180px');
      } else {
        setButtonSize('120px');
      }
    };

    updateButtonSize();
    window.addEventListener('resize', updateButtonSize);
    return () => window.removeEventListener('resize', updateButtonSize);
  }, []);

  return (
    <main className="min-h-screen bg-white relative overflow-hidden">
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

        {/* Content */}
      <div className="relative z-10 flex flex-col items-center justify-center min-h-screen">
        {/* Rope for the disco ball */}
        <div className="absolute top-0 left-0 w-full h-full pointer-events-none z-0">
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
            {/* Main rope line - always goes through center */}
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
        <div className="flex justify-center mb-8">
        <button 
          id="big-play-button"
          className="group relative bg-white/5 hover:bg-white/8 backdrop-blur-sm rounded-full transition-all duration-500 hover:scale-105 hover:shadow-2xl border-2 overflow-hidden cursor-pointer z-20"
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
              </div>

        {/* Webchella Title */}
            <div className="relative z-10 mb-8">
              <h2 className="text-[4rem] sm:text-[6rem] md:text-[8rem] lg:text-[12rem] font-bold text-white text-center cursor-pointer transition-all duration-300 group px-4" style={{ 
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
            </div>

            {/* Tech Stack Logos */}
            <div className="relative z-10">
              <div className="flex flex-wrap justify-center items-center gap-2 sm:gap-3 md:gap-4 px-2 sm:px-4">
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
                </div>
              </div>
            </div>

      {/* Footer with Spotify Playlist */}
      <footer className="relative z-10 mt-16 pb-8">
        <div className="max-w-4xl mx-auto px-4">
          <div className="text-center">
            <a 
              href="https://buymeacoffee.com/yourusername" 
              target="_blank" 
              rel="noopener noreferrer"
              className="inline-flex items-center gap-3 bg-amber-500 hover:bg-amber-600 text-white font-semibold px-6 py-4 rounded-xl shadow-lg hover:shadow-xl transition-all duration-300 hover:scale-105"
            >
              <Coffee className="w-6 h-6" />
              Buy me a coffee
            </a>
            
            <p className="text-white/60 text-xs mt-4">
              Made with ❤️ and lots of coffee
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
