'use client'

import React from 'react'

export default function Home() {
  return (
    <main className="min-h-screen bg-background">
      <div className="container mx-auto px-4 py-8">
        <div className="max-w-4xl mx-auto">
          <h1 className="text-4xl font-bold text-foreground mb-8">
            Blueberry Prompt Kit Showcase
          </h1>
          
          <div className="space-y-8">
            <section className="bg-secondary p-6 rounded-lg">
              <h2 className="text-2xl font-semibold mb-4">Framework Overview</h2>
              <p className="text-secondary-foreground mb-4">
                The Blueberry Prompt Kit is a comprehensive framework for building web applications 
                with AI agents. It provides strict guardrails, proven patterns, and a systematic 
                approach to development.
              </p>
              <div className="grid md:grid-cols-2 gap-4">
                <div className="bg-background p-4 rounded">
                  <h3 className="font-semibold mb-2">Data-First Development</h3>
                  <p className="text-sm text-muted-foreground">
                    Start with database schema, build APIs, then create UI components.
                  </p>
                </div>
                <div className="bg-background p-4 rounded">
                  <h3 className="font-semibold mb-2">Type Safety Everywhere</h3>
                  <p className="text-sm text-muted-foreground">
                    End-to-end TypeScript with tRPC, Zod validation, and Drizzle ORM.
                  </p>
                </div>
              </div>
            </section>

            <section className="bg-secondary p-6 rounded-lg">
              <h2 className="text-2xl font-semibold mb-4">Development Methodology</h2>
              <div className="grid md:grid-cols-3 gap-4">
                <div className="bg-background p-4 rounded">
                  <h3 className="font-semibold mb-2">Phase 1: Data Planning</h3>
                  <p className="text-sm text-muted-foreground">
                    Plan features, model data, design APIs, map user flows.
                  </p>
                </div>
                <div className="bg-background p-4 rounded">
                  <h3 className="font-semibold mb-2">Phase 2: Database</h3>
                  <p className="text-sm text-muted-foreground">
                    Create Drizzle schemas, run migrations, set up relationships.
                  </p>
                </div>
                <div className="bg-background p-4 rounded">
                  <h3 className="font-semibold mb-2">Phase 3: API</h3>
                  <p className="text-sm text-muted-foreground">
                    Build tRPC procedures, add validation, implement auth.
                  </p>
                </div>
                <div className="bg-background p-4 rounded">
                  <h3 className="font-semibold mb-2">Phase 4: UI</h3>
                  <p className="text-sm text-muted-foreground">
                    Create Next.js pages, build components, apply styling.
                  </p>
                </div>
                <div className="bg-background p-4 rounded">
                  <h3 className="font-semibold mb-2">Phase 5: Polish</h3>
                  <p className="text-sm text-muted-foreground">
                    Add loading states, error handling, optimize performance.
                  </p>
                </div>
                <div className="bg-background p-4 rounded">
                  <h3 className="font-semibold mb-2">Phase 6: Testing</h3>
                  <p className="text-sm text-muted-foreground">
                    Write tests, verify functionality, ensure quality.
                  </p>
                </div>
              </div>
            </section>

            <section className="bg-secondary p-6 rounded-lg">
              <h2 className="text-2xl font-semibold mb-4">Technology Stack</h2>
              <div className="grid md:grid-cols-2 gap-6">
                <div>
                  <h3 className="font-semibold mb-3">Frontend</h3>
                  <ul className="space-y-2 text-sm">
                    <li>• Next.js 14+ (App Router)</li>
                    <li>• TypeScript (strict mode)</li>
                    <li>• Tailwind CSS</li>
                    <li>• shadcn/ui components</li>
                  </ul>
                </div>
                <div>
                  <h3 className="font-semibold mb-3">Backend</h3>
                  <ul className="space-y-2 text-sm">
                    <li>• Supabase (PostgreSQL)</li>
                    <li>• Drizzle ORM</li>
                    <li>• tRPC + Zod</li>
                    <li>• Better Auth</li>
                  </ul>
                </div>
              </div>
            </section>

            <section className="bg-secondary p-6 rounded-lg">
              <h2 className="text-2xl font-semibold mb-4">Get Started</h2>
              <div className="space-y-4">
                <div className="bg-background p-4 rounded">
                  <h3 className="font-semibold mb-2">1. Get Framework Files</h3>
                  <div className="space-y-2">
                    <div className="flex items-center gap-2">
                      <code className="text-sm bg-muted px-2 py-1 rounded flex-1">
                        git clone https://github.com/your-username/blueberry-prompt-kit.git
                      </code>
                      <button 
                        onClick={() => navigator.clipboard.writeText('git clone https://github.com/your-username/blueberry-prompt-kit.git')}
                        className="px-3 py-1 bg-primary text-primary-foreground rounded text-sm hover:bg-primary/90 transition-colors"
                      >
                        Copy
                      </button>
                    </div>
                    <p className="text-xs text-muted-foreground">
                      Gets complete framework: .cursorrules, docs/, agents/, templates/
                    </p>
                  </div>
                </div>
                <div className="bg-background p-4 rounded">
                  <h3 className="font-semibold mb-2">2. Install Dependencies</h3>
                  <div className="flex items-center gap-2 mb-2">
                    <code className="text-sm bg-muted px-2 py-1 rounded flex-1">
                      npm install @supabase/supabase-js drizzle-orm @trpc/server @trpc/client
                    </code>
                    <button 
                      onClick={() => navigator.clipboard.writeText('npm install @supabase/supabase-js drizzle-orm @trpc/server @trpc/client')}
                      className="px-3 py-1 bg-primary text-primary-foreground rounded text-sm hover:bg-primary/90 transition-colors"
                    >
                      Copy
                    </button>
                  </div>
                </div>
                <div className="bg-background p-4 rounded">
                  <h3 className="font-semibold mb-2">3. Get Full Framework</h3>
                  <div className="space-y-2">
                    <div className="flex items-center gap-2">
                      <a 
                        href="/api/download-framework"
                        download="blueberry-prompt-kit-complete.txt"
                        className="px-4 py-2 bg-primary text-primary-foreground rounded text-sm hover:bg-primary/90 transition-colors inline-flex items-center gap-2"
                      >
                        📦 Download Complete Framework
                      </a>
                      <button 
                        onClick={() => navigator.clipboard.writeText('git clone https://github.com/your-username/blueberry-prompt-kit.git')}
                        className="px-3 py-1 bg-secondary text-secondary-foreground rounded text-sm hover:bg-secondary/90 transition-colors"
                      >
                        Copy Git Clone
                      </button>
                    </div>
                    <p className="text-xs text-muted-foreground">
                      Includes: Complete docs, agents, templates, examples, setup guides
                    </p>
                  </div>
                </div>
                <div className="bg-background p-4 rounded">
                  <h3 className="font-semibold mb-2">4. Start Building</h3>
                  <p className="text-sm text-muted-foreground">
                    Follow the 6-phase methodology with AI agents guiding each step.
                  </p>
                </div>
              </div>
            </section>

            <section className="bg-secondary p-6 rounded-lg">
              <h2 className="text-2xl font-semibold mb-4">Framework Benefits</h2>
              <div className="grid md:grid-cols-2 gap-4">
                <div className="bg-background p-4 rounded">
                  <h3 className="font-semibold mb-2">Impossible to Mess Up</h3>
                  <p className="text-sm text-muted-foreground">
                    Strict guardrails prevent over-engineering and ensure consistent results.
                  </p>
                </div>
                <div className="bg-background p-4 rounded">
                  <h3 className="font-semibold mb-2">Type Safety Everywhere</h3>
                  <p className="text-sm text-muted-foreground">
                    End-to-end TypeScript with tRPC, Zod validation, and Drizzle ORM.
                  </p>
                </div>
                <div className="bg-background p-4 rounded">
                  <h3 className="font-semibold mb-2">Production Ready</h3>
                  <p className="text-sm text-muted-foreground">
                    Complete with testing, deployment, and performance optimization.
                  </p>
                </div>
                <div className="bg-background p-4 rounded">
                  <h3 className="font-semibold mb-2">AI-Friendly</h3>
                  <p className="text-sm text-muted-foreground">
                    Designed for seamless AI agent coordination and development.
                  </p>
                </div>
              </div>
            </section>
          </div>
        </div>
      </div>
    </main>
  )
}
