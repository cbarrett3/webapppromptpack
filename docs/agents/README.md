# webapppromptpack Agent System

## Streamlined Agent Ecosystem

### **Agent Structure**
```
PM Agent (Product Management)
├── Roadmap Management
├── Technical Ticket Writing
└── Design Mindset

Full-Stack Agent (Development)
├── Database Design & Migration
├── API Development (tRPC + Zod)
├── UI Development (shadcn/ui + Tailwind)
├── Testing (Unit + Component + Integration)
└── Polish (Loading + Error Handling + Accessibility)
```

## Agent Roles & Responsibilities

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

### **PM Agent → Full-Stack Agent**
1. **PM Agent** writes clear, actionable ticket
2. **Full-Stack Agent** receives ticket with requirements
3. **Full-Stack Agent** builds complete feature
4. **Feature complete** and ready for production

### **Communication Protocol**
```markdown
**PM AGENT HANDOFF TO FULL-STACK AGENT:**

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

## Quality Standards

### **PM Agent Quality**
- [ ] Clear, actionable tickets created
- [ ] Realistic roadmaps established
- [ ] Features prioritized by value
- [ ] Dependencies identified early
- [ ] Design requirements specified

### **Full-Stack Agent Quality**
- [ ] Database schema created and tested
- [ ] API procedures built and validated
- [ ] UI components created and responsive
- [ ] Tests written and passing
- [ ] Accessibility compliance verified
- [ ] Performance optimized

## Best Practices

### **PM Agent Best Practices**
1. **User Story Format** - "As a [user], I want [feature] so that [benefit]"
2. **Specific Acceptance Criteria** - Testable, measurable requirements
3. **Technical Clarity** - Clear technical specifications
4. **Design Considerations** - UI/UX requirements included
5. **Dependency Mapping** - Identify blockers early

### **Full-Stack Agent Best Practices**
1. **Database First** - Plan schema before API
2. **API Second** - Build procedures before UI
3. **UI Last** - Connect components to API
4. **Test Everything** - Write tests as you build
5. **Polish Last** - Add loading states and error handling

## Success Criteria

### **PM Agent Success**
- [ ] Clear, actionable tickets created
- [ ] Realistic roadmaps established
- [ ] Features prioritized by value
- [ ] Dependencies identified early
- [ ] Design requirements specified

### **Full-Stack Agent Success**
- [ ] All acceptance criteria met
- [ ] Database schema created and tested
- [ ] API procedures built and validated
- [ ] UI components created and responsive
- [ ] Tests written and passing
- [ ] Accessibility compliance verified
- [ ] Performance optimized

## Why This Structure Works

### **For Cursor Development:**
- **Simpler** - Two focused agents instead of complex coordination
- **Faster** - No handoff delays or coordination overhead
- **More Natural** - Matches how developers actually work
- **Less Confusing** - Clear, single responsibilities

### **For Framework Adoption:**
- **Easier to Learn** - Two agents to understand
- **Faster Onboarding** - No complex agent coordination
- **Better Results** - Agents have full context of their domain
- **More Practical** - Matches real development workflows

**The ultimate goal: Enable efficient, high-quality development through focused, capable agents that work together seamlessly.**