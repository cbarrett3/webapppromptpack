import type { Metadata } from "next";
import React from "react";
import "./globals.css";

export const metadata: Metadata = {
  title: "webchella",
  description:
    "The full-stack lineup you've been waiting for - A production-ready framework with Next.js, tRPC, Drizzle, and AI agents",
  icons: {
    icon: '/favicon.ico',
  },
  openGraph: {
    title: "webchella",
    description: "The full-stack lineup you've been waiting for - A production-ready framework with Next.js, tRPC, Drizzle, and AI agents",
    type: "website",
    siteName: "webchella",
    url: "https://webchella.dev",
    images: [
      {
        url: "https://webchella.dev/webchella.png",
        width: 1200,
        height: 630,
        alt: "webchella - Full-stack development framework",
      },
    ],
  },
  twitter: {
    card: "summary_large_image",
    title: "webchella",
    description: "The full-stack lineup you've been waiting for - A production-ready framework with Next.js, tRPC, Drizzle, and AI agents",
    creator: "@coookiecrisp97",
    images: ["https://webchella.dev/webchella.png"],
  },
};

export default function RootLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  return (
    <html lang="en">
      <body>{children}</body>
    </html>
  );
}
