# tRPC Procedure Templates

## Core Procedure Patterns

### **Query Procedures**
```typescript
// Get all items
const getAllItems = publicProcedure
  .query(async () => {
    return db.items.findMany()
  })

// Get item by ID
const getItemById = publicProcedure
  .input(z.object({ id: z.string() }))
  .query(async ({ input }) => {
    return db.items.findUnique({
      where: { id: input.id }
    })
  })

// Get user's items
const getUserItems = protectedProcedure
  .query(async ({ ctx }) => {
    return db.items.findMany({
      where: { userId: ctx.user.id }
    })
  })
```

### **Mutation Procedures**
```typescript
// Create item
const createItem = protectedProcedure
  .input(z.object({
    title: z.string().min(1).max(200),
    content: z.string().min(1).max(10000)
  }))
  .mutation(async ({ ctx, input }) => {
    return db.items.create({
      data: {
        ...input,
        userId: ctx.user.id
      }
    })
  })

// Update item
const updateItem = protectedProcedure
  .input(z.object({
    id: z.string(),
    title: z.string().min(1).max(200).optional(),
    content: z.string().min(1).max(10000).optional()
  }))
  .mutation(async ({ ctx, input }) => {
    const { id, ...data } = input
    
    // Verify ownership
    const item = await db.items.findFirst({
      where: { id, userId: ctx.user.id }
    })
    
    if (!item) {
      throw new TRPCError({ code: 'NOT_FOUND' })
    }
    
    return db.items.update({
      where: { id },
      data
    })
  })

// Delete item
const deleteItem = protectedProcedure
  .input(z.object({ id: z.string() }))
  .mutation(async ({ ctx, input }) => {
    // Verify ownership
    const item = await db.items.findFirst({
      where: { id: input.id, userId: ctx.user.id }
    })
    
    if (!item) {
      throw new TRPCError({ code: 'NOT_FOUND' })
    }
    
    return db.items.delete({
      where: { id: input.id }
    })
  })
```

### **Admin Procedures**
```typescript
// Admin-only procedures
const getAllUsers = adminProcedure
  .query(async () => {
    return db.users.findMany()
  })

const deleteUser = adminProcedure
  .input(z.object({ id: z.string() }))
  .mutation(async ({ input }) => {
    return db.users.delete({
      where: { id: input.id }
    })
  })
```

---

## Validation Patterns

### **Input Validation**
```typescript
// User validation
const userSchema = z.object({
  email: z.string().email().toLowerCase(),
  name: z.string().min(1).max(100).trim(),
  age: z.number().int().min(0).max(120)
})

// Post validation
const postSchema = z.object({
  title: z.string().min(1).max(200).trim(),
  content: z.string().min(1).max(10000).trim(),
  published: z.boolean().default(false)
})

// Update validation
const updatePostSchema = z.object({
  id: z.string(),
  title: z.string().min(1).max(200).trim().optional(),
  content: z.string().min(1).max(10000).trim().optional(),
  published: z.boolean().optional()
})
```

### **Output Validation**
```typescript
// Response schemas
const userResponseSchema = z.object({
  id: z.string(),
  email: z.string(),
  name: z.string(),
  createdAt: z.date(),
  updatedAt: z.date()
})

const postResponseSchema = z.object({
  id: z.string(),
  title: z.string(),
  content: z.string(),
  published: z.boolean(),
  userId: z.string(),
  createdAt: z.date(),
  updatedAt: z.date()
})
```

---

## Error Handling Patterns

### **Custom Error Types**
```typescript
// Custom error classes
export class ValidationError extends Error {
  constructor(message: string) {
    super(message)
    this.name = 'ValidationError'
  }
}

export class NotFoundError extends Error {
  constructor(message: string) {
    super(message)
    this.name = 'NotFoundError'
  }
}

// Error handling in procedures
const getPostById = protectedProcedure
  .input(z.object({ id: z.string() }))
  .query(async ({ ctx, input }) => {
    try {
      const post = await db.posts.findUnique({
        where: { id: input.id }
      })
      
      if (!post) {
        throw new TRPCError({ 
          code: 'NOT_FOUND',
          message: 'Post not found'
        })
      }
      
      return post
    } catch (error) {
      logger.error('Failed to get post', { error, userId: ctx.user.id })
      throw new TRPCError({ 
        code: 'INTERNAL_SERVER_ERROR',
        message: 'Failed to get post'
      })
    }
  })
```

### **Error Recovery**
```typescript
// Retry logic
const createPostWithRetry = protectedProcedure
  .input(postSchema)
  .mutation(async ({ ctx, input }) => {
    let attempts = 0
    const maxAttempts = 3
    
    while (attempts < maxAttempts) {
      try {
        return await db.posts.create({
          data: { ...input, userId: ctx.user.id }
        })
      } catch (error) {
        attempts++
        if (attempts >= maxAttempts) {
          logger.error('Failed to create post after retries', { error })
          throw new TRPCError({ 
            code: 'INTERNAL_SERVER_ERROR',
            message: 'Failed to create post'
          })
        }
        await new Promise(resolve => setTimeout(resolve, 1000 * attempts))
      }
    }
  })
```

---

## Caching Patterns

### **Simple Caching**
```typescript
// In-memory cache
const cache = new Map<string, any>()

const getCachedPosts = publicProcedure
  .query(async () => {
    const cacheKey = 'posts:all'
    const cached = cache.get(cacheKey)
    
    if (cached) {
      return cached
    }
    
    const posts = await db.posts.findMany()
    cache.set(cacheKey, posts)
    
    return posts
  })
```

### **TTL Caching**
```typescript
// Cache with TTL
const cacheWithTTL = new Map<string, { data: any, expires: number }>()

const getCachedPostsWithTTL = publicProcedure
  .query(async () => {
    const cacheKey = 'posts:all'
    const cached = cacheWithTTL.get(cacheKey)
    
    if (cached && cached.expires > Date.now()) {
      return cached.data
    }
    
    const posts = await db.posts.findMany()
    cacheWithTTL.set(cacheKey, {
      data: posts,
      expires: Date.now() + 5 * 60 * 1000 // 5 minutes
    })
    
    return posts
  })
```

---

## External API Integration

### **External API Calls**
```typescript
// External API integration
const getWeatherData = publicProcedure
  .input(z.object({ city: z.string() }))
  .query(async ({ input }) => {
    // Check cache first
    const cached = await db.weather.findFirst({
      where: { 
        city: input.city, 
        updatedAt: { gte: new Date(Date.now() - 3600000) } 
      }
    })
    
    if (cached) {
      return cached.data
    }
    
    // Fetch from external API
    const response = await fetch(`https://api.weather.com/${input.city}`, {
      headers: {
        'Authorization': `Bearer ${process.env.WEATHER_API_KEY}`
      }
    })
    
    if (!response.ok) {
      throw new TRPCError({ 
        code: 'BAD_REQUEST',
        message: 'Failed to fetch weather data'
      })
    }
    
    const data = await response.json()
    
    // Cache the result
    await db.weather.upsert({
      where: { city: input.city },
      update: { data, updatedAt: new Date() },
      create: { city: input.city, data, updatedAt: new Date() }
    })
    
    return data
  })
```

### **Background Jobs**
```typescript
// Background job integration
const processLargeData = protectedProcedure
  .input(z.object({ data: z.string() }))
  .mutation(async ({ ctx, input }) => {
    // Start background job
    const job = await trigger.dev.jobs.create({
      name: 'process-data',
      payload: { 
        data: input.data,
        userId: ctx.user.id 
      }
    })
    
    return { jobId: job.id }
  })
```

---

## Pagination Patterns

### **Cursor-based Pagination**
```typescript
// Cursor-based pagination
const getPostsPaginated = publicProcedure
  .input(z.object({
    cursor: z.string().optional(),
    limit: z.number().min(1).max(100).default(10)
  }))
  .query(async ({ input }) => {
    const { cursor, limit } = input
    
    const posts = await db.posts.findMany({
      take: limit + 1,
      cursor: cursor ? { id: cursor } : undefined,
      orderBy: { createdAt: 'desc' }
    })
    
    let nextCursor: string | undefined = undefined
    if (posts.length > limit) {
      const nextItem = posts.pop()
      nextCursor = nextItem!.id
    }
    
    return {
      posts,
      nextCursor
    }
  })
```

### **Offset-based Pagination**
```typescript
// Offset-based pagination
const getPostsWithOffset = publicProcedure
  .input(z.object({
    page: z.number().min(1).default(1),
    limit: z.number().min(1).max(100).default(10)
  }))
  .query(async ({ input }) => {
    const { page, limit } = input
    const offset = (page - 1) * limit
    
    const [posts, total] = await Promise.all([
      db.posts.findMany({
        skip: offset,
        take: limit,
        orderBy: { createdAt: 'desc' }
      }),
      db.posts.count()
    ])
    
    return {
      posts,
      pagination: {
        page,
        limit,
        total,
        pages: Math.ceil(total / limit)
      }
    }
  })
```

---

## Search Patterns

### **Full-text Search**
```typescript
// Full-text search
const searchPosts = publicProcedure
  .input(z.object({
    query: z.string().min(1),
    limit: z.number().min(1).max(100).default(10)
  }))
  .query(async ({ input }) => {
    const { query, limit } = input
    
    return db.posts.findMany({
      where: {
        OR: [
          { title: { contains: query, mode: 'insensitive' } },
          { content: { contains: query, mode: 'insensitive' } }
        ]
      },
      take: limit,
      orderBy: { createdAt: 'desc' }
    })
  })
```

### **Advanced Search**
```typescript
// Advanced search with filters
const searchPostsAdvanced = publicProcedure
  .input(z.object({
    query: z.string().optional(),
    category: z.string().optional(),
    published: z.boolean().optional(),
    dateFrom: z.date().optional(),
    dateTo: z.date().optional(),
    limit: z.number().min(1).max(100).default(10)
  }))
  .query(async ({ input }) => {
    const { query, category, published, dateFrom, dateTo, limit } = input
    
    const where: any = {}
    
    if (query) {
      where.OR = [
        { title: { contains: query, mode: 'insensitive' } },
        { content: { contains: query, mode: 'insensitive' } }
      ]
    }
    
    if (category) {
      where.category = category
    }
    
    if (published !== undefined) {
      where.published = published
    }
    
    if (dateFrom || dateTo) {
      where.createdAt = {}
      if (dateFrom) where.createdAt.gte = dateFrom
      if (dateTo) where.createdAt.lte = dateTo
    }
    
    return db.posts.findMany({
      where,
      take: limit,
      orderBy: { createdAt: 'desc' }
    })
  })
```

---

## Real-time Patterns

### **Subscription Procedures**
```typescript
// Real-time subscriptions
const subscribeToPosts = protectedProcedure
  .subscription(async function* ({ ctx }) {
    // This would typically use WebSockets or Server-Sent Events
    // For now, we'll simulate with polling
    while (true) {
      const posts = await db.posts.findMany({
        where: { userId: ctx.user.id },
        orderBy: { createdAt: 'desc' }
      })
      
      yield posts
      
      // Wait 5 seconds before next update
      await new Promise(resolve => setTimeout(resolve, 5000))
    }
  })
```

---

## Testing Patterns

### **Unit Test Examples**
```typescript
// Unit test for tRPC procedure
describe('getUserPosts', () => {
  it('should return user posts', async () => {
    const mockUser = { id: 'user-1', email: 'test@example.com' }
    const mockPosts = [
      { id: 'post-1', title: 'Test Post', userId: 'user-1' }
    ]
    
    // Mock database
    jest.spyOn(db.posts, 'findMany').mockResolvedValue(mockPosts)
    
    const result = await getUserPosts({
      ctx: { user: mockUser },
      input: {}
    })
    
    expect(result).toEqual(mockPosts)
    expect(db.posts.findMany).toHaveBeenCalledWith({
      where: { userId: 'user-1' }
    })
  })
})
```

### **Integration Test Examples**
```typescript
// Integration test for tRPC router
describe('Posts Router', () => {
  it('should create and retrieve posts', async () => {
    const caller = appRouter.createCaller({
      user: { id: 'user-1', email: 'test@example.com' }
    })
    
    // Create post
    const createdPost = await caller.posts.create({
      title: 'Test Post',
      content: 'Test Content'
    })
    
    expect(createdPost.title).toBe('Test Post')
    
    // Get posts
    const posts = await caller.posts.getUserPosts()
    expect(posts).toHaveLength(1)
    expect(posts[0].title).toBe('Test Post')
  })
})
```

---

## Performance Optimization

### **Query Optimization**
```typescript
// Optimized queries
const getPostsWithAuthors = publicProcedure
  .query(async () => {
    return db.posts.findMany({
      include: {
        author: {
          select: {
            id: true,
            name: true,
            email: true
          }
        }
      },
      orderBy: { createdAt: 'desc' }
    })
  })
```

### **Batch Operations**
```typescript
// Batch operations
const createMultiplePosts = protectedProcedure
  .input(z.array(postSchema))
  .mutation(async ({ ctx, input }) => {
    const posts = input.map(post => ({
      ...post,
      userId: ctx.user.id
    }))
    
    return db.posts.createMany({
      data: posts
    })
  })
```

**These templates provide a solid foundation for building tRPC procedures that follow the Blueberry Prompt Kit framework patterns.**
