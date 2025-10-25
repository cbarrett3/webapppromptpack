# webapppromptpack Framework

## Core Philosophy: "Impossible to Mess Up"

**Strong opinions, proven patterns, and strict constraints that make it nearly impossible to build bad software when following this framework.**

## Architecture Principles

### **1. "Everything Through tRPC"**
- **No REST APIs** - All communication via tRPC procedures
- **External APIs hidden** - All external calls wrapped in tRPC procedures
- **Type safety end-to-end** - Client and server share TypeScript types
- **No OpenAPI needed** - tRPC is self-documenting

### **2. "Database-First Development"**
- **Drizzle schemas drive everything**
- **tRPC procedures built on database models**
- **Zod validation for all inputs/outputs**
- **Better Auth integration with user context**

### **3. "Cache External Data"**
- **External APIs → tRPC procedures → Supabase cache → Frontend**
- **No direct external API calls from frontend**
- **Server-side API keys and authentication**
- **Graceful error handling and fallbacks**

## Data Flow Architecture

### **Unidirectional Data Flow**
```
Database (Supabase) → Drizzle ORM → tRPC Procedures → React Components → UI
```

### **External API Integration**
```
External API → tRPC Procedure → Supabase Cache → Frontend
```

### **Authentication Flow**
```
User Login → Better Auth → Session → tRPC Context → Protected Procedures
```

## Code Standards

### **TypeScript Rules**
- **Strict mode**: No `any` types, explicit returns
- **Consistent imports**: Use `import type` for types
- **No non-null assertions**: Use proper null checks
- **Prefer readonly**: Use `readonly` for immutable data

### **React Best Practices**
- **Functional components**: Use function components with hooks
- **Custom hooks**: Extract reusable logic into custom hooks
- **Error boundaries**: Wrap components in error boundaries
- **Memoization**: Use `useMemo` and `useCallback` appropriately

### **Performance Rules**
- **No floating promises**: Always await or handle promises
- **Exhaustive deps**: Include all dependencies in useEffect
- **Bundle optimization**: Use dynamic imports for large components
- **Image optimization**: Use Next.js Image component

## Testing Strategy

### **Unit Tests**
- **tRPC procedures**: Test all API endpoints
- **Utility functions**: Test all helper functions
- **Custom hooks**: Test all custom React hooks

### **Component Tests**
- **User interactions**: Test all user interactions
- **Accessibility**: Test keyboard navigation and screen readers
- **Error states**: Test error handling and loading states

### **Integration Tests**
- **API integration**: Test external API integrations
- **Database operations**: Test database queries and mutations
- **Authentication**: Test login/logout flows

## Security & Performance

### **Security Rules**
- **Input validation**: Validate all inputs with Zod
- **Authentication**: Use Better Auth for all protected routes
- **CSRF protection**: Use CSRF tokens for mutations
- **Rate limiting**: Implement rate limiting for API endpoints

### **Performance Rules**
- **Bundle size**: Monitor and optimize bundle size
- **Database queries**: Optimize database queries
- **Caching**: Implement proper caching strategies
- **Monitoring**: Use Pino for logging and monitoring

## AI Agent Coordination

### **PM Agent**
- **Roadmap Management** - Strategic planning and feature prioritization
- **Technical Ticket Writing** - Clear, actionable tickets with acceptance criteria
- **Design Mindset** - User experience and technical design considerations

### **Full-Stack Agent**
- **Database Design** - Drizzle schemas, migrations, relationships
- **API Development** - tRPC procedures, Zod validation, authentication
- **UI Development** - shadcn/ui components, Tailwind CSS 4+, responsive design
- **Testing** - Unit, component, and integration tests
- **Polish** - Loading states, error handling, accessibility

## Agent Workflow

### **PM Agent → Full-Stack Agent Handoff**
```markdown
**Feature:** [Feature Name]
**Priority:** [High/Medium/Low]
**Effort:** [XS/S/M/L/XL]

**Requirements:**
- [Clear description of what needs to be built]
- [User story and acceptance criteria]
- [Technical specifications]
- [Design requirements]

**Dependencies:**
- [Other features that must be completed first]
- [External dependencies]

**Success Criteria:**
- [How to know when it's done]
- [Quality standards to meet]
```
