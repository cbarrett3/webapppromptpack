'use client'

import React from 'react'

export default function Home() {
  return (
    <main className="min-h-screen bg-background">
      <div className="container mx-auto px-4 py-8">
        <div className="max-w-4xl mx-auto">
          {/* ASCII Art Header */}
          <div className="text-center mb-12 relative">
            <div className="absolute inset-0 bg-gradient-to-r from-purple-500/10 via-cyan-500/10 to-pink-500/10 rounded-lg blur-xl"></div>
            <pre className="text-xs md:text-sm font-mono text-foreground/90 leading-tight mb-6 relative z-10 drop-shadow-lg">
{`              ___.                                                            __                       __ 
__  _  __ ____\\_ |__ _____  ______ ______ _____________  ____   _____ _______/  |____________    ____ |  | __
\\ \\/ \\/ // __ \\| __ \\\\__  \\ \\____ \\\\____ \\\\____ \\_  __ \\/  _ \\ /     \\\\____ \\   __\\____ \\__  \\ _/ ___\\|  |/ /
 \\     /\\  ___/| \\_\\ \\/ __ \\|  |_> >  |_> >  |_> >  | \\(  <_> )  Y Y  \\  |_> >  | |  |_> > __ \\\\  \\___|    < 
  \\/\\_/  \\___  >___  (____  /   __/|   __/|   __/|__|   \\____/|__|_|  /   __/|__| |   __(____  /\\___  >__|_ \\
             \\/    \\/     \\/|__|   |__|   |__|                      \\/|__|        |__|       \\/     \\/     \\/`}
            </pre>
            <h1 className="text-4xl md:text-6xl font-bold text-foreground mb-4">
              webapppromptpack
            </h1>
            <p className="text-lg text-muted-foreground mb-8">
              A comprehensive framework for building web applications with AI agents
            </p>
          </div>
          
          <div className="space-y-12">
            <section className="bg-gradient-to-br from-secondary to-secondary/80 p-8 rounded-xl border border-border/50 shadow-2xl relative overflow-hidden">
              {/* Spooky glow effect */}
              <div className="absolute inset-0 bg-gradient-to-r from-purple-500/10 via-blue-500/10 to-cyan-500/10 animate-pulse"></div>
              <div className="relative z-10">
                <h2 className="text-3xl font-bold mb-6 text-transparent bg-clip-text bg-gradient-to-r from-white to-cyan-300">
                  Framework Overview
                </h2>
                <p className="text-secondary-foreground mb-6 text-lg leading-relaxed">
                  The webapppromptpack is a comprehensive framework for building web applications 
                  with AI agents. It provides strict guardrails, proven patterns, and a systematic 
                  approach to development that makes it <strong className="text-cyan-300">impossible to mess up</strong>.
                </p>
                <div className="grid md:grid-cols-2 gap-6">
                  <div className="bg-background/80 backdrop-blur-sm p-6 rounded-lg border border-cyan-500/20 hover:border-cyan-400/40 transition-all duration-300 hover:shadow-lg hover:shadow-cyan-500/10">
                    <h3 className="font-bold mb-3 text-cyan-200">Data-First Development</h3>
                    <p className="text-sm text-muted-foreground leading-relaxed">
                      Start with database schema, build APIs, then create UI components.
                    </p>
                  </div>
                  <div className="bg-background/80 backdrop-blur-sm p-6 rounded-lg border border-cyan-500/20 hover:border-cyan-400/40 transition-all duration-300 hover:shadow-lg hover:shadow-cyan-500/10">
                    <h3 className="font-bold mb-3 text-cyan-200">Type Safety Everywhere</h3>
                    <p className="text-sm text-muted-foreground leading-relaxed">
                      End-to-end TypeScript with tRPC, Zod validation, and Drizzle ORM.
                    </p>
                  </div>
                </div>
              </div>
            </section>

            <section className="bg-gradient-to-br from-secondary to-secondary/80 p-8 rounded-xl border border-border/50 shadow-2xl relative overflow-hidden">
              {/* Spooky animated background */}
              <div className="absolute inset-0 bg-gradient-to-r from-purple-500/5 via-pink-500/5 to-cyan-500/5 animate-pulse"></div>
              <div className="absolute top-0 left-0 w-full h-1 bg-gradient-to-r from-purple-500 via-pink-500 to-cyan-500 animate-pulse"></div>
              <div className="relative z-10">
                <h2 className="text-3xl font-bold mb-6 text-transparent bg-clip-text bg-gradient-to-r from-white to-pink-300">
                  Development Methodology
                </h2>
                <div className="grid md:grid-cols-3 gap-6">
                  <div className="bg-background/80 backdrop-blur-sm p-6 rounded-lg border border-purple-500/20 hover:border-purple-400/40 transition-all duration-300 hover:shadow-lg hover:shadow-purple-500/10 group">
                    <h3 className="font-bold mb-3 text-purple-200 group-hover:text-purple-100 transition-colors">Phase 1: Data Planning</h3>
                    <p className="text-sm text-muted-foreground leading-relaxed">
                      Plan features, model data, design APIs, map user flows.
                    </p>
                  </div>
                  <div className="bg-background/80 backdrop-blur-sm p-6 rounded-lg border border-pink-500/20 hover:border-pink-400/40 transition-all duration-300 hover:shadow-lg hover:shadow-pink-500/10 group">
                    <h3 className="font-bold mb-3 text-pink-200 group-hover:text-pink-100 transition-colors">Phase 2: Database</h3>
                    <p className="text-sm text-muted-foreground leading-relaxed">
                      Create Drizzle schemas, run migrations, set up relationships.
                    </p>
                  </div>
                  <div className="bg-background/80 backdrop-blur-sm p-6 rounded-lg border border-cyan-500/20 hover:border-cyan-400/40 transition-all duration-300 hover:shadow-lg hover:shadow-cyan-500/10 group">
                    <h3 className="font-bold mb-3 text-cyan-200 group-hover:text-cyan-100 transition-colors">Phase 3: API</h3>
                    <p className="text-sm text-muted-foreground leading-relaxed">
                      Build tRPC procedures, add validation, implement auth.
                    </p>
                  </div>
                  <div className="bg-background/80 backdrop-blur-sm p-6 rounded-lg border border-green-500/20 hover:border-green-400/40 transition-all duration-300 hover:shadow-lg hover:shadow-green-500/10 group">
                    <h3 className="font-bold mb-3 text-green-200 group-hover:text-green-100 transition-colors">Phase 4: UI</h3>
                    <p className="text-sm text-muted-foreground leading-relaxed">
                      Create Next.js pages, build components, apply styling.
                    </p>
                  </div>
                  <div className="bg-background/80 backdrop-blur-sm p-6 rounded-lg border border-yellow-500/20 hover:border-yellow-400/40 transition-all duration-300 hover:shadow-lg hover:shadow-yellow-500/10 group">
                    <h3 className="font-bold mb-3 text-yellow-200 group-hover:text-yellow-100 transition-colors">Phase 5: Polish</h3>
                    <p className="text-sm text-muted-foreground leading-relaxed">
                      Add loading states, error handling, optimize performance.
                    </p>
                  </div>
                  <div className="bg-background/80 backdrop-blur-sm p-6 rounded-lg border border-red-500/20 hover:border-red-400/40 transition-all duration-300 hover:shadow-lg hover:shadow-red-500/10 group">
                    <h3 className="font-bold mb-3 text-red-200 group-hover:text-red-100 transition-colors">Phase 6: Testing</h3>
                    <p className="text-sm text-muted-foreground leading-relaxed">
                      Write tests, verify functionality, ensure quality.
                    </p>
                  </div>
                </div>
              </div>
            </section>

            <section className="bg-gradient-to-br from-secondary to-secondary/80 p-6 rounded-lg border border-border/50 shadow-lg">
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

            <section className="bg-gradient-to-br from-secondary to-secondary/80 p-8 rounded-xl border border-border/50 shadow-2xl relative overflow-hidden">
              {/* Spooky animated background */}
              <div className="absolute inset-0 bg-gradient-to-r from-green-500/5 via-blue-500/5 to-purple-500/5 animate-pulse"></div>
              <div className="absolute top-0 left-0 w-full h-1 bg-gradient-to-r from-green-500 via-blue-500 to-purple-500 animate-pulse"></div>
              <div className="relative z-10">
                <h2 className="text-3xl font-bold mb-6 text-transparent bg-clip-text bg-gradient-to-r from-white to-green-300">
                  🚀 Start Building in 2 Minutes
                </h2>
                <div className="space-y-6">
                  <div className="bg-background/80 backdrop-blur-sm p-6 rounded-lg border border-green-500/20 hover:border-green-400/40 transition-all duration-300 hover:shadow-lg hover:shadow-green-500/10">
                    <h3 className="font-bold mb-3 text-green-200 text-lg">⚡ Zero-Friction Start</h3>
                    <div className="space-y-3">
                      <div className="flex items-center gap-3">
                        <code className="text-sm bg-muted px-3 py-2 rounded flex-1 font-mono">
                          curl -sSL https://raw.githubusercontent.com/cbarrett3/webapppromptpack/main/templates/setup-script.sh | bash -s my-app
                        </code>
                        <button 
                          onClick={() => navigator.clipboard.writeText('curl -sSL https://raw.githubusercontent.com/cbarrett3/webapppromptpack/main/templates/setup-script.sh | bash -s my-app')}
                          className="px-4 py-2 bg-gradient-to-r from-green-600 to-emerald-600 text-white rounded-lg text-sm font-medium hover:from-green-500 hover:to-emerald-500 transition-all duration-300 shadow-lg hover:shadow-green-500/25 hover:scale-105 border border-green-400/30"
                        >
                          📋 Copy
                        </button>
                      </div>
                      <p className="text-sm text-muted-foreground">
                        ✅ Complete setup • ✅ All configs included • ✅ Ready to code • ✅ Zero redundancy
                      </p>
                    </div>
                  </div>

                  <div className="bg-background/80 backdrop-blur-sm p-6 rounded-lg border border-blue-500/20 hover:border-blue-400/40 transition-all duration-300 hover:shadow-lg hover:shadow-blue-500/10">
                    <h3 className="font-bold mb-3 text-blue-200 text-lg">🎯 What's Included</h3>
                    <div className="space-y-3">
                      <div className="grid md:grid-cols-2 gap-4">
                        <div className="space-y-2">
                          <h4 className="font-semibold text-blue-100">Configuration Files:</h4>
                          <ul className="text-sm text-muted-foreground space-y-1">
                            <li>• Next.js 16 config with TypeScript</li>
                            <li>• Tailwind CSS 4+ with animations</li>
                            <li>• Strict ESLint with 30+ rules</li>
                            <li>• Prettier + EditorConfig</li>
                            <li>• Husky git hooks</li>
                            <li>• Commitlint + Lint-staged</li>
                          </ul>
                        </div>
                        <div className="space-y-2">
                          <h4 className="font-semibold text-blue-100">Project Structure:</h4>
                          <ul className="text-sm text-muted-foreground space-y-1">
                            <li>• Complete directory structure</li>
                            <li>• Core utility functions</li>
                            <li>• Type definitions</li>
                            <li>• Test setup files</li>
                          </ul>
                        </div>
                      </div>
                      <p className="text-sm text-muted-foreground">
                        ✅ Everything configured • ✅ Best practices included • ✅ Ready to build
                      </p>
                    </div>
                  </div>

                  <div className="bg-background/80 backdrop-blur-sm p-6 rounded-lg border border-purple-500/20 hover:border-purple-400/40 transition-all duration-300 hover:shadow-lg hover:shadow-purple-500/10">
                    <h3 className="font-bold mb-3 text-purple-200 text-lg">🎨 Optional: Add Backend Later</h3>
                    <div className="space-y-3">
                      <div className="grid md:grid-cols-2 gap-4">
                        <div className="space-y-2">
                          <h4 className="font-semibold text-purple-100">Start Simple:</h4>
                          <ul className="text-sm text-muted-foreground space-y-1">
                            <li>• Local SQLite database</li>
                            <li>• File-based storage</li>
                            <li>• Mock authentication</li>
                          </ul>
                        </div>
                        <div className="space-y-2">
                          <h4 className="font-semibold text-purple-100">Scale Up Later:</h4>
                          <ul className="text-sm text-muted-foreground space-y-1">
                            <li>• Add Supabase when ready</li>
                            <li>• Add Stripe for payments</li>
                            <li>• Add Resend for emails</li>
                          </ul>
                        </div>
                      </div>
                      <p className="text-sm text-muted-foreground">
                        ✅ Build first, configure later • ✅ No upfront decisions • ✅ Start coding immediately
                      </p>
                    </div>
                  </div>

                  <div className="bg-background/80 backdrop-blur-sm p-6 rounded-lg border border-yellow-500/20 hover:border-yellow-400/40 transition-all duration-300 hover:shadow-lg hover:shadow-yellow-500/10">
                    <h3 className="font-bold mb-3 text-yellow-200 text-lg">🎉 You're Ready!</h3>
                    <div className="space-y-3">
                      <div className="flex items-center gap-3">
                        <code className="text-sm bg-muted px-3 py-2 rounded flex-1 font-mono">
                          cd my-app && npm run dev
                        </code>
                        <button 
                          onClick={() => navigator.clipboard.writeText('cd my-app && npm run dev')}
                          className="px-4 py-2 bg-gradient-to-r from-yellow-600 to-orange-600 text-white rounded-lg text-sm font-medium hover:from-yellow-500 hover:to-orange-500 transition-all duration-300 shadow-lg hover:shadow-yellow-500/25 hover:scale-105 border border-yellow-400/30"
                        >
                          📋 Copy
                        </button>
                      </div>
                      <p className="text-sm text-muted-foreground">
                        ✅ Start building immediately • ✅ AI agents guide you • ✅ Impossible to mess up
                      </p>
                    </div>
                  </div>
                </div>
              </div>
            </section>

            <section className="bg-gradient-to-br from-secondary to-secondary/80 p-6 rounded-lg border border-border/50 shadow-lg">
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
