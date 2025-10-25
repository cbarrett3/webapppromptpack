"use client";

import * as THREE from "three";
import { useRef, useState } from "react";
import { Canvas, useFrame } from "@react-three/fiber";
import { Clouds, Cloud, CameraControls, Sky as SkyImpl } from "@react-three/drei";

export default function Home() {
  const [activeLabels, setActiveLabels] = useState<Set<string>>(new Set());

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
        <div className="text-center mb-8">
          <h1 className="text-6xl md:text-8xl font-bold text-white mb-6 tracking-tight drop-shadow-lg">
            <span className="bg-gradient-to-r from-blue-400 to-purple-400 bg-clip-text text-transparent">
              Showcase
            </span>
          </h1>
          <p className="text-xl text-white max-w-md mx-auto drop-shadow-lg">
            Minimal design with maximum impact
          </p>
              </div>

            {/* Vibey Stack Title */}
            <div className="relative z-10 mb-8">
              <h2 className="text-[8rem] md:text-[12rem] font-bold text-white text-center drop-shadow-2xl cursor-pointer transition-all duration-300 group" style={{ fontFamily: 'Inter, -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif', fontWeight: '900', letterSpacing: '-0.02em', lineHeight: '0.8' }}>
                <span 
                  className="inline-block transition-all duration-300" 
                  style={{ 
                    animation: 'balloon 4s ease-in-out infinite',
                    animationDelay: '0s'
                  }}
                >V</span>
                <span 
                  className="inline-block transition-all duration-300" 
                  style={{ 
                    animation: 'balloon 4s ease-in-out infinite',
                    animationDelay: '0.2s'
                  }}
                >i</span>
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
                >e</span>
                <span 
                  className="inline-block transition-all duration-300" 
                  style={{ 
                    animation: 'balloon 4s ease-in-out infinite',
                    animationDelay: '0.8s'
                  }}
                >y</span>
                <span className="inline-block mx-6"> </span>
                <span 
                  className="inline-block transition-all duration-300" 
                  style={{ 
                    animation: 'balloon 4s ease-in-out infinite',
                    animationDelay: '1.2s'
                  }}
                >S</span>
                <span 
                  className="inline-block transition-all duration-300" 
                  style={{ 
                    animation: 'balloon 4s ease-in-out infinite',
                    animationDelay: '1.4s'
                  }}
                >t</span>
                <span 
                  className="inline-block transition-all duration-300" 
                  style={{ 
                    animation: 'balloon 4s ease-in-out infinite',
                    animationDelay: '1.6s'
                  }}
                >a</span>
                <span 
                  className="inline-block transition-all duration-300" 
                  style={{ 
                    animation: 'balloon 4s ease-in-out infinite',
                    animationDelay: '1.8s'
                  }}
                >c</span>
                <span 
                  className="inline-block transition-all duration-300" 
                  style={{ 
                    animation: 'balloon 4s ease-in-out infinite',
                    animationDelay: '2.0s'
                  }}
                >k</span>
              </h2>
            </div>

            {/* Tech Stack Logos */}
            <div className="relative z-10">
              <div className="flex flex-wrap justify-center items-center gap-3 md:gap-4 px-4">
          <div 
            className="flex items-center justify-center px-6 py-4 bg-white/20 backdrop-blur-lg rounded-xl shadow-2xl cursor-pointer transition-all duration-300" 
            style={{ 
              padding: '16px 24px', 
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
            <span className="text-white font-bold text-base drop-shadow-2xl" style={{ fontWeight: 'bold', fontSize: '16px', textShadow: '0 2px 4px rgba(0, 0, 0, 0.5)', fontFamily: 'Inter, -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif' }}>tRPC</span>
          </div>
          <div 
            className="flex items-center justify-center px-6 py-4 bg-white/20 backdrop-blur-lg rounded-xl shadow-2xl cursor-pointer transition-all duration-300" 
            style={{ 
              padding: '16px 24px', 
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
            <span className="text-white font-bold text-base drop-shadow-2xl" style={{ fontWeight: 'bold', fontSize: '16px', textShadow: '0 2px 4px rgba(0, 0, 0, 0.5)', fontFamily: 'Inter, -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif' }}>Drizzle</span>
          </div>
          <div 
            className="flex items-center justify-center px-6 py-4 bg-white/20 backdrop-blur-lg rounded-xl shadow-2xl cursor-pointer transition-all duration-300" 
            style={{ 
              padding: '16px 24px', 
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
            <span className="text-white font-bold text-base drop-shadow-2xl" style={{ fontWeight: 'bold', fontSize: '16px', textShadow: '0 2px 4px rgba(0, 0, 0, 0.5)', fontFamily: 'Inter, -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif' }}>TypeScript</span>
        </div>
          <div 
            className="flex items-center justify-center px-6 py-4 bg-white/20 backdrop-blur-lg rounded-xl shadow-2xl cursor-pointer transition-all duration-300" 
            style={{ 
              padding: '16px 24px', 
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
            <span className="text-white font-bold text-base drop-shadow-2xl" style={{ fontWeight: 'bold', fontSize: '16px', textShadow: '0 2px 4px rgba(0, 0, 0, 0.5)', fontFamily: 'Inter, -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif' }}>Next.js</span>
          </div>
          <div 
            className="flex items-center justify-center px-6 py-4 bg-white/20 backdrop-blur-lg rounded-xl shadow-2xl cursor-pointer transition-all duration-300" 
            style={{ 
              padding: '16px 24px', 
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
            <span className="text-white font-bold text-base drop-shadow-2xl" style={{ fontWeight: 'bold', fontSize: '16px', textShadow: '0 2px 4px rgba(0, 0, 0, 0.5)', fontFamily: 'Inter, -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif' }}>Zod</span>
        </div>
          <div 
            className="flex items-center justify-center px-6 py-4 bg-white/20 backdrop-blur-lg rounded-xl shadow-2xl cursor-pointer transition-all duration-300" 
            style={{ 
              padding: '16px 24px', 
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
            <span className="text-white font-bold text-base drop-shadow-2xl" style={{ fontWeight: 'bold', fontSize: '16px', textShadow: '0 2px 4px rgba(0, 0, 0, 0.5)', fontFamily: 'Inter, -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif' }}>React</span>
                </div>
          <div 
            className="flex items-center justify-center px-6 py-4 bg-white/20 backdrop-blur-lg rounded-xl shadow-2xl cursor-pointer transition-all duration-300" 
            style={{ 
              padding: '16px 24px', 
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
            <span className="text-white font-bold text-base drop-shadow-2xl" style={{ fontWeight: 'bold', fontSize: '16px', textShadow: '0 2px 4px rgba(0, 0, 0, 0.5)', fontFamily: 'Inter, -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif' }}>Better Auth</span>
                </div>
          <div 
            className="flex items-center justify-center px-6 py-4 bg-white/20 backdrop-blur-lg rounded-xl shadow-2xl cursor-pointer transition-all duration-300" 
            style={{ 
              padding: '16px 24px', 
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
            <span className="text-white font-bold text-base drop-shadow-2xl" style={{ fontWeight: 'bold', fontSize: '16px', textShadow: '0 2px 4px rgba(0, 0, 0, 0.5)', fontFamily: 'Inter, -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif' }}>Radix</span>
                    </div>
          <div 
            className="flex items-center justify-center px-6 py-4 bg-white/20 backdrop-blur-lg rounded-xl shadow-2xl cursor-pointer transition-all duration-300" 
            style={{ 
              padding: '16px 24px', 
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
            <span className="text-white font-bold text-base drop-shadow-2xl" style={{ fontWeight: 'bold', fontSize: '16px', textShadow: '0 2px 4px rgba(0, 0, 0, 0.5)', fontFamily: 'Inter, -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif' }}>Tailwind</span>
              </div>
            </div>
        </div>
      </div>
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
