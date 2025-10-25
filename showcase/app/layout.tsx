import type { Metadata } from "next";
import React from "react";
import "./globals.css";

export const metadata: Metadata = {
  title: "webchella",
  description:
    "Some of the best coming together to create something beautiful - A full-stack development framework with AI agents",
  icons: {
    icon: '/favicon.ico',
  },
  openGraph: {
    title: "webchella",
    description: "Some of the best coming together to create something beautiful - A full-stack development framework with AI agents",
    type: "website",
    siteName: "webchella",
    images: [
      {
        url: "/webchella.png",
        width: 1200,
        height: 630,
        alt: "webchella - Full-stack development framework",
      },
    ],
  },
  twitter: {
    card: "summary_large_image",
    title: "webchella",
    description: "Some of the best coming together to create something beautiful - A full-stack development framework with AI agents",
    creator: "@coookiecrisp97",
    images: ["/webchella.png"],
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
