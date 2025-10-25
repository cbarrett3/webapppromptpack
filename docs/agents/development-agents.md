# Development Agents (Phase 1-6)

## Phase 1 Agent: Data Planning

### **Your Role**
Plan features and data requirements only.

### **What You Do:**
1. Define the feature clearly
2. Identify data needs (tables, relationships, constraints)
3. Plan API endpoints (tRPC procedures needed)
4. Plan user flow and interactions
5. Sketch rough UI layout

### **What You DON'T Do:**
- Write any code
- Create database schemas
- Build components
- Add dependencies

### **Output Format:**
- Feature description
- Data requirements
- API endpoint list
- User flow diagram
- UI wireframe

### **Next Step:** Hand off to Phase 2 Agent for database implementation.

---

## Phase 2 Agent: Database Layer

### **Your Role**
Create database schema and migrations only.

### **What You Do:**
1. Create Drizzle schemas based on Phase 1 planning
2. Define relationships and constraints
3. Write database migrations
4. Test schema with sample data
5. Document schema decisions

### **What You DON'T Do:**
- Write tRPC procedures
- Create components
- Add business logic
- Skip to UI

### **Output Format:**
- Drizzle schema files
- Migration files
- Schema documentation
- Test data examples

### **Next Step:** Hand off to Phase 3 Agent for API implementation.

---

## Phase 3 Agent: API Layer

### **Your Role**
Build tRPC procedures and validation only.

### **What You Do:**
1. Create tRPC procedures based on Phase 1 planning
2. Add Zod validation for all inputs/outputs
3. Implement error handling
4. Add authentication/authorization
5. Test with tRPC playground

### **What You DON'T Do:**
- Create UI components
- Skip validation
- Add business logic outside tRPC
- Move to UI without completing API

### **Output Format:**
- tRPC procedure files
- Zod validation schemas
- Error handling patterns
- API documentation

### **Next Step:** Hand off to Phase 4 Agent for UI implementation.

---

## Phase 4 Agent: UI Layer (with Design Agent)

### **Your Role**
Create components and pages with Midday.ai inspired design - immaculate, clean, and sophisticated.

### **What You Do:**
1. Create Next.js pages and layouts
2. Build components using shadcn/ui with Midday.ai aesthetic
3. Apply Tailwind CSS 4+ styling with immaculate clean design
4. Connect components to tRPC procedures
5. Implement responsive design with dark mode excellence
6. Focus on data-first design and sophisticated typography

### **What You DON'T Do:**
- Add business logic
- Skip design system
- Create custom components when shadcn/ui exists
- Move to polish without completing UI

### **Output Format:**
- Page components
- Reusable components
- Styled layouts
- Responsive design

### **Next Step:** Hand off to Phase 5 Agent for polish and optimization.

---

## Phase 5 Agent: Polish

### **Your Role**
Add polish and optimize only.

### **What You Do:**
1. Add loading states and skeletons
2. Implement error boundaries
3. Add toast notifications
4. Optimize performance
5. Test accessibility

### **What You DON'T Do:**
- Add new features
- Change core functionality
- Skip error handling
- Move to testing without completing polish

### **Output Format:**
- Loading components
- Error boundaries
- Toast implementations
- Performance optimizations

### **Next Step:** Hand off to Phase 6 Agent for testing and verification.

---

## Phase 6 Agent: Testing

### **Your Role**
Write tests and verify functionality only.

### **What You Do:**
1. Write unit tests for tRPC procedures
2. Write component tests for UI
3. Write integration tests for API
4. Test accessibility compliance
5. Verify end-to-end functionality

### **What You DON'T Do:**
- Add new features
- Change existing code
- Skip test coverage
- Move to deployment without testing

### **Output Format:**
- Unit test files
- Component test files
- Integration test files
- Test documentation

### **Next Step:** Ready for deployment and production.

---

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

## Quality Standards

### **Phase 1: Data Planning**
- [ ] Feature clearly defined
- [ ] Data requirements identified
- [ ] API endpoints planned
- [ ] User flow documented
- [ ] UI wireframe created

### **Phase 2: Database Layer**
- [ ] Drizzle schemas created
- [ ] Relationships defined
- [ ] Migrations written
- [ ] Schema tested
- [ ] Documentation updated

### **Phase 3: API Layer**
- [ ] tRPC procedures created
- [ ] Zod validation added
- [ ] Error handling implemented
- [ ] Authentication added
- [ ] API tested

### **Phase 4: UI Layer**
- [ ] Pages created
- [ ] Components built
- [ ] Styling applied
- [ ] tRPC connected
- [ ] Responsive design implemented

### **Phase 5: Polish**
- [ ] Loading states added
- [ ] Error boundaries implemented
- [ ] Toast notifications added
- [ ] Performance optimized
- [ ] Accessibility tested

### **Phase 6: Testing**
- [ ] Unit tests written
- [ ] Component tests written
- [ ] Integration tests written
- [ ] Accessibility tested
- [ ] End-to-end functionality verified

## Handoff Protocol

### **Phase Handoff Template**
```markdown
**PHASE HANDOFF: [Current Phase] → [Next Phase]**

**Completed in [Current Phase]:**
- [List of completed items]
- [Files created/modified]
- [Tests written]
- [Documentation updated]

**Ready for [Next Phase]:**
- [Requirements met]
- [Dependencies satisfied]
- [Approval received]

**Next Phase Requirements:**
- [What needs to be done]
- [Dependencies needed]
- [Expected deliverables]

**Handoff to:** [Next Phase Agent]
```

### **Approval Request Template**
```markdown
**PHASE APPROVAL REQUEST: [Current Phase]**

**Phase Completion Summary:**
- [What was accomplished]
- [Files created/modified]
- [Tests written]
- [Documentation updated]

**Quality Checklist:**
- [ ] All requirements met
- [ ] Code quality standards followed
- [ ] Tests written and passing
- [ ] Documentation updated
- [ ] No errors or warnings

**Request Approval to Proceed to:** [Next Phase]

**Estimated Time for Next Phase:** [Time estimate]
```

## Common Patterns

### **Phase 1: Data Planning Patterns**
```typescript
// Feature description template
interface Feature {
  name: string
  description: string
  userStory: string
  acceptanceCriteria: string[]
  dataRequirements: DataRequirement[]
  apiEndpoints: APIEndpoint[]
  userFlow: UserFlowStep[]
  uiWireframe: UIWireframe
}

// Data requirement template
interface DataRequirement {
  table: string
  columns: Column[]
  relationships: Relationship[]
  constraints: Constraint[]
}
```

### **Phase 2: Database Patterns**
```typescript
// Drizzle schema pattern
export const users = pgTable('users', {
  id: uuid('id').primaryKey().defaultRandom(),
  email: text('email').notNull().unique(),
  name: text('name').notNull(),
  createdAt: timestamp('created_at').defaultNow(),
  updatedAt: timestamp('updated_at').defaultNow()
})

// Migration pattern
export const createUsersTable = sql`
  CREATE TABLE users (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    email TEXT NOT NULL UNIQUE,
    name TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
  );
`
```

### **Phase 3: API Patterns**
```typescript
// tRPC procedure pattern
const getUserPosts = protectedProcedure
  .input(z.object({ limit: z.number().min(1).max(100).default(10) }))
  .query(async ({ ctx, input }) => {
    return db.posts.findMany({
      where: { userId: ctx.user.id },
      take: input.limit
    })
  })

// Zod validation pattern
const postSchema = z.object({
  title: z.string().min(1).max(200),
  content: z.string().min(1).max(10000),
  published: z.boolean().default(false)
})
```

### **Phase 4: UI Patterns**
```typescript
// Page component pattern
export default async function PostsPage() {
  const posts = await api.posts.getAll()
  
  return (
    <div className="container mx-auto p-4">
      <h1 className="text-2xl font-bold mb-4">Posts</h1>
      <PostsList posts={posts} />
    </div>
  )
}

// Component pattern
export function PostsList({ posts }: { posts: Post[] }) {
  return (
    <div className="grid gap-4">
      {posts.map(post => (
        <PostCard key={post.id} post={post} />
      ))}
    </div>
  )
}
```

### **Phase 5: Polish Patterns**
```typescript
// Loading state pattern
export function LoadingSpinner() {
  return (
    <div className="flex items-center justify-center p-4">
      <div className="animate-spin rounded-full h-8 w-8 border-b-2 border-primary"></div>
    </div>
  )
}

// Error boundary pattern
export function ErrorBoundary({ children }: { children: React.ReactNode }) {
  const [hasError, setHasError] = useState(false)
  
  if (hasError) {
    return <div>Something went wrong. Please refresh the page.</div>
  }
  
  return <>{children}</>
}
```

### **Phase 6: Testing Patterns**
```typescript
// Unit test pattern
describe('getUserPosts', () => {
  it('should return user posts', async () => {
    const result = await getUserPosts({ userId: 'user-1' })
    expect(result).toHaveLength(2)
  })
})

// Component test pattern
describe('PostsList', () => {
  it('renders posts correctly', () => {
    render(<PostsList posts={mockPosts} />)
    expect(screen.getByText('Post 1')).toBeInTheDocument()
  })
})
```

## Success Criteria

### **Phase 1 Success**
- [ ] Feature clearly defined and documented
- [ ] Data requirements identified
- [ ] API endpoints planned
- [ ] User flow documented
- [ ] UI wireframe created

### **Phase 2 Success**
- [ ] Database schema created
- [ ] Migrations written and tested
- [ ] Relationships defined
- [ ] Constraints implemented
- [ ] Documentation updated

### **Phase 3 Success**
- [ ] tRPC procedures created
- [ ] Validation implemented
- [ ] Error handling added
- [ ] Authentication integrated
- [ ] API tested

### **Phase 4 Success**
- [ ] Pages created
- [ ] Components built
- [ ] Styling applied
- [ ] tRPC connected
- [ ] Responsive design implemented

### **Phase 5 Success**
- [ ] Loading states added
- [ ] Error boundaries implemented
- [ ] Toast notifications added
- [ ] Performance optimized
- [ ] Accessibility tested

### **Phase 6 Success**
- [ ] Unit tests written
- [ ] Component tests written
- [ ] Integration tests written
- [ ] Accessibility tested
- [ ] End-to-end functionality verified

**Each phase must be completed successfully before moving to the next phase.**
