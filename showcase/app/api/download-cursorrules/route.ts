import { NextResponse } from 'next/server'
import fs from 'fs'
import path from 'path'

export async function GET() {
  try {
    // Read the .cursorrules file from the parent directory
    const cursorRulesPath = path.join(process.cwd(), '..', '.cursorrules')
    const cursorRulesContent = fs.readFileSync(cursorRulesPath, 'utf8')
    
    return new NextResponse(cursorRulesContent, {
      headers: {
        'Content-Type': 'text/plain',
        'Content-Disposition': 'attachment; filename=".cursorrules"',
      },
    })
  } catch (error) {
    console.error('Error reading .cursorrules file:', error)
    return new NextResponse('Error reading .cursorrules file', { status: 500 })
  }
}
