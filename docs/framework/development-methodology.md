# Development Methodology

## Core Philosophy: "Data-First, Back-to-Front Development"

**Strong opinions based on what works in the real world, with minimal complexity and maximum type safety.**

## Development Process (6 Phases)

### **Phase 1: Data Planning (10 minutes)**
**Focus**: Plan features, data needs, database schema

**What You Do:**
1. Define the feature clearly
2. Identify data needs (tables, relationships, constraints)
3. Plan API endpoints (tRPC procedures needed)
4. Plan user flow and interactions
5. Sketch rough UI layout

**What You DON'T Do:**
- Write any code
- Create database schemas
- Build components
- Add dependencies

**Deliverables:**
- Feature description
- Data requirements
- API endpoint list
- User flow diagram
- UI wireframe

**Next Step**: Hand off to Phase 2 Agent for database implementation.

### **Phase 2: Database Layer (20 minutes)**
**Focus**: Create database schema and migrations

**What You Do:**
1. Create Drizzle schemas based on Phase 1 planning
2. Define relationships and constraints
3. Write database migrations
4. Test schema with sample data
5. Document schema decisions

**What You DON'T Do:**
- Write tRPC procedures
- Create components
- Add business logic
- Skip to UI

**Deliverables:**
- Drizzle schema files
- Migration files
- Schema documentation
- Test data examples

**Next Step**: Hand off to Phase 3 Agent for API implementation.

### **Phase 3: API Layer (15 minutes)**
**Focus**: Build tRPC procedures and validation

**What You Do:**
1. Create tRPC procedures based on Phase 1 planning
2. Add Zod validation for all inputs/outputs
3. Implement error handling
4. Add authentication/authorization
5. Test with tRPC playground

**What You DON'T Do:**
- Create UI components
- Skip validation
- Add business logic outside tRPC
- Move to UI without completing API

**Deliverables:**
- tRPC procedure files
- Zod validation schemas
- Error handling patterns
- API documentation

**Next Step**: Hand off to Phase 4 Agent for UI implementation.

### **Phase 4: UI Layer (20 minutes)**
**Focus**: Create components and pages

**What You Do:**
1. Create Next.js pages and layouts
2. Build components using shadcn/ui
3. Apply Tailwind styling with design tokens
4. Connect components to tRPC procedures
5. Implement responsive design

**What You DON'T Do:**
- Add business logic
- Skip design system
- Create custom components when shadcn/ui exists
- Move to polish without completing UI

**Deliverables:**
- Page components
- Reusable components
- Styled layouts
- Responsive design

**Next Step**: Hand off to Phase 5 Agent for polish and optimization.

### **Phase 5: Polish (10 minutes)**
**Focus**: Add polish and optimize

**What You Do:**
1. Add loading states and skeletons
2. Implement error boundaries
3. Add toast notifications
4. Optimize performance
5. Test accessibility

**What You DON'T Do:**
- Add new features
- Change core functionality
- Skip error handling
- Move to testing without completing polish

**Deliverables:**
- Loading components
- Error boundaries
- Toast implementations
- Performance optimizations

**Next Step**: Hand off to Phase 6 Agent for testing and verification.

### **Phase 6: Testing (10 minutes)**
**Focus**: Write tests and verify functionality

**What You Do:**
1. Write unit tests for tRPC procedures
2. Write component tests for UI
3. Write integration tests for API
4. Test accessibility compliance
5. Verify end-to-end functionality

**What You DON'T Do:**
- Add new features
- Change existing code
- Skip test coverage
- Move to deployment without testing

**Deliverables:**
- Unit test files
- Component test files
- Integration test files
- Test documentation

**Next Step**: Ready for deployment and production.

## Phase Gate Rules

### **Strict Phase Gates**
1. **"Complete Phase 1 before Phase 2"** - No database work without planning
2. **"Complete Phase 2 before Phase 3"** - No API work without database
3. **"Complete Phase 3 before Phase 4"** - No pages without API
4. **"Complete Phase 4 before Phase 5"** - No components without pages
5. **"Complete Phase 5 before Phase 6"** - No polish without functionality

### **Within Each Phase**
- **"Ask before moving to next phase"** - Get approval to proceed
- **"Complete all items in current phase"** - No jumping around
- **"Test current phase before proceeding"** - Validate each step

## Why This Order Works

### **Prevents Common AI Mistakes**
- Building UI without data structure
- Creating components without API endpoints
- Adding features without planning
- Jumping between phases randomly

### **Ensures Solid Foundation**
- Data model drives everything
- API contracts are clear
- UI is built on solid backend
- Testing happens at the right time

### **Scales from Simple to Complex**
- Personal site: Phases 1-4 might be enough
- Restaurant site: Add Phase 5
- SaaS platform: All phases, multiple iterations

## Development Principles

### **1. Simplicity First**
```typescript
// ✅ Good: Simple, readable
const getUserPosts = protectedProcedure
  .query(async ({ ctx }) => {
    return db.posts.findMany({ where: { userId: ctx.user.id } })
  })

// ❌ Bad: Over-engineered
const getUserPosts = protectedProcedure
  .query(async ({ ctx }) => {
    const user = await db.users.findUnique({ where: { id: ctx.user.id } })
    if (!user) throw new Error('User not found')
    const posts = await db.posts.findMany({ where: { userId: user.id } })
    return posts.map(post => ({ ...post, author: user }))
  })
```

### **2. DRY (Don't Repeat Yourself)**
```typescript
// ✅ Good: Reusable validation
const postSchema = z.object({
  title: z.string().min(1).max(200),
  content: z.string().min(1).max(10000)
})

const createPost = protectedProcedure
  .input(postSchema)
  .mutation(async ({ ctx, input }) => {
    return db.posts.create({ data: { ...input, userId: ctx.user.id } })
  })

const updatePost = protectedProcedure
  .input(z.object({ id: z.string() }).merge(postSchema))
  .mutation(async ({ ctx, input }) => {
    return db.posts.update({ where: { id: input.id }, data: input })
  })
```

### **3. Single Responsibility**
```typescript
// ✅ Good: One responsibility per function
const getUserPosts = protectedProcedure
  .query(async ({ ctx }) => {
    return db.posts.findMany({ where: { userId: ctx.user.id } })
  })

const createPost = protectedProcedure
  .input(postSchema)
  .mutation(async ({ ctx, input }) => {
    return db.posts.create({ data: { ...input, userId: ctx.user.id } })
  })

// ❌ Bad: Multiple responsibilities
const handleUserPosts = protectedProcedure
  .query(async ({ ctx }) => {
    const posts = await db.posts.findMany({ where: { userId: ctx.user.id } })
    const user = await db.users.findUnique({ where: { id: ctx.user.id } })
    return { posts, user }
  })
```

### **4. Explicit Dependencies**
```typescript
// ✅ Good: Explicit dependencies
const createPost = protectedProcedure
  .input(postSchema)
  .mutation(async ({ ctx, input }) => {
    const post = await db.posts.create({
      data: { ...input, userId: ctx.user.id }
    })
    
    // Explicit dependency injection
    await emailService.sendNotification(post)
    await analyticsService.trackEvent('post_created', { postId: post.id })
    
    return post
  })
```

## Code Quality Principles

### **1. Readable Code**
```typescript
// ✅ Good: Clear intent
const getUserPosts = protectedProcedure
  .query(async ({ ctx }) => {
    return db.posts.findMany({ where: { userId: ctx.user.id } })
  })

// ❌ Bad: Unclear intent
const getPosts = protectedProcedure
  .query(async ({ ctx }) => {
    return db.posts.findMany({ where: { userId: ctx.user.id } })
  })
```

### **2. DRY Code**
```typescript
// ✅ Good: Reusable validation
const postSchema = z.object({
  title: z.string().min(1).max(200),
  content: z.string().min(1).max(10000)
})

// ❌ Bad: Repeated validation
const createPost = protectedProcedure
  .input(z.object({
    title: z.string().min(1).max(200),
    content: z.string().min(1).max(10000)
  }))
  .mutation(async ({ ctx, input }) => {
    return db.posts.create({ data: { ...input, userId: ctx.user.id } })
  })
```

### **3. Explicit Code**
```typescript
// ✅ Good: Explicit types
interface User {
  id: string
  email: string
  role: 'admin' | 'user'
}

const getUser = protectedProcedure
  .query(async ({ ctx }): Promise<User> => {
    return db.users.findUnique({ where: { id: ctx.user.id } })
  })

// ❌ Bad: Implicit types
const getUser = protectedProcedure
  .query(async ({ ctx }) => {
    return db.users.findUnique({ where: { id: ctx.user.id } })
  })
```

## AI Guardrails for Development Process

### **Development Process Rules**
1. **"Follow the 6-phase development process"** - No jumping around
2. **"Complete current phase before next phase"** - No partial implementations
3. **"Ask before adding complexity"** - Justify every addition
4. **"Use existing patterns"** - Don't reinvent the wheel
5. **"Test each phase before proceeding"** - Verify functionality

### **Code Quality Rules**
1. **"Write readable, DRY code"** - Clear intent, no repetition
2. **"Use explicit types"** - No implicit any types
3. **"Follow single responsibility"** - One purpose per function
4. **"Use design tokens"** - No hardcoded values
5. **"Apply responsive design"** - Mobile-first approach

### **Data Flow Rules**
1. **"Server-to-client data flow"** - Server components fetch, client components receive
2. **"Unidirectional state updates"** - Clear data flow direction
3. **"Use tRPC for all data fetching"** - No direct database calls
4. **"Validate all inputs"** - Use Zod schemas
5. **"Handle errors gracefully"** - Proper error boundaries

## Complete Development Ideology

### **Core Tenets**
1. **Data-First Planning** - Database schema drives everything
2. **Back-to-Front Development** - Data → API → UI → Polish
3. **Simplicity First** - Start simple, add complexity only when needed
4. **Readable Code** - Code should read like well-written prose
5. **DRY Principle** - Don't repeat yourself, but don't over-abstract
6. **Single Responsibility** - One purpose per function, component, or module
7. **Explicit Dependencies** - Clear what each piece depends on
8. **Unidirectional Data Flow** - Data flows in one direction
9. **Design by Default** - Beautiful UI from the start
10. **Type Safety** - Catch errors at compile time
11. **Test-Driven** - Write tests as you build
12. **Performance Conscious** - Fast by default

### **Development Process**
1. **Plan** - Define the feature and requirements
2. **Data** - Create database schema and API
3. **UI** - Build components and pages
4. **Polish** - Add loading states, error handling, responsiveness
5. **Test** - Verify functionality and accessibility
6. **Deploy** - Ship to production

This methodology ensures **great results EVERY TIME** by providing clear constraints, proven patterns, and a systematic approach to building web applications.
