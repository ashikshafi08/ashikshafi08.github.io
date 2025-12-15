---
layout: post
title: "Building Grok Interviewer at the xAI Hackathon"
date: 2025-12-14
description: My experience building an AI-powered interview simulator at the xAI Hackathon using Grok Voice and tools that aren't even public yet
tags: ai hackathon xai grok voice interview
categories: projects
---

Crazy week. I got into the xAI Hackathon and built alongside 420 other engineers. We worked with tools and features that aren't even public yet. I joined the Grok Voice track and built "Grok Interviewer" in about 17 hours—a conversational AI that interviews you naturally and turns the session into structured content.

{% include figure.html path="assets/img/xai-elon.jpg" caption="Elon Musk at the xAI Hackathon" max-width="100%" %}

The whole experience was intense. I've been traveling a lot to San Francisco for events and hackathons lately, and this one was definitely one of the most rewarding. I'm learning fast, building fast, and meeting incredible people in AI.

## What I Built

Grok Interviewer is an AI-powered interview simulator that stitches together HR, technical, and coding rounds with a shared context. Candidates speak with distinct interviewer personas over voice, tackle live coding prompts in a Monaco IDE, and finish with automatically generated scorecards.

The platform includes:
- Multi-round voice interviews powered by XAI's realtime API and persona-specific prompts
- Monaco-based coding workspace with timers, tabs, and a built-in test runner
- Handoff pipeline that carries discussion topics, claims, and follow-ups between rounds
- Dashboard views for jobs, candidates, transcripts, and reports

{% include video.html path="https://www.youtube.com/embed/w2ZOxkmLqt8" caption="Demo of Grok Interviewer" max-width="100%" %}

The voice integration was the most interesting part. Using XAI's realtime API, I could create natural conversations where the AI interviewer adapts based on what you say. The handoff between rounds means the technical interviewer knows what you discussed in the HR round, and the coding round can reference earlier conversations.

## The Event

{% include figure.html path="assets/img/xai-hack-cyber.jpg" caption="Tesla Cybertrucks at the xAI office" max-width="100%" %}

The hackathon was at the xAI office, and seeing all those Cybertrucks parked outside was pretty surreal. The energy was incredible—420 engineers all working on different projects, all pushing the boundaries of what's possible with AI.

{% include figure.html path="assets/img/xai-hack-myself.jpg" caption="At the xAI Hackathon" max-width="100%" %}

Working with tools that aren't public yet was both exciting and challenging. You're figuring things out as you go, but that's part of what makes hackathons so fun. The community was super helpful, and everyone was sharing what they learned.

## How I Built It

I built this entire platform from scratch in about 17 hours. Here's how it all came together:

### Tech Stack

I went with **Next.js 16** and **React 19** for the frontend. The App Router made it easy to structure the different interview rounds and dashboard views. For the coding workspace, I integrated **Monaco Editor** (the same editor that powers VS Code) so candidates get a familiar coding environment with syntax highlighting, autocomplete, and all that good stuff.

The voice integration uses **XAI's realtime API**, which was the core of the whole thing. I had to figure out how to handle audio streams, convert between different audio formats, and manage WebSocket connections—all while keeping the conversation flowing naturally.

### Voice Integration

The trickiest part was getting the voice to work smoothly. I built custom React hooks (`use-interview-voice` and `use-interview-audio`) to handle the entire audio lifecycle. The browser captures audio as PCM16, but XAI's API needs Float32, so I had to write conversion utilities in `audio-utils.ts` to transform the audio stream in real-time.

The session flow works like this: when a candidate starts an interview, the frontend calls `/api/interview/session` which generates an ephemeral token from XAI. This token gets wired up with a persona-specific prompt that I crafted for each round type (HR, technical, coding). The prompts live in `interview-prompts.ts` and they're pretty detailed—each persona has its own personality, questioning style, and evaluation criteria.

### Round Handoff System

One of the coolest features is the handoff between rounds. I built a system in `round-handoff.ts` that captures key discussion points, claims the candidate made, and follow-up questions from each round. When you move to the technical round, the interviewer already knows what you talked about in HR. Same thing when you hit the coding round—the interviewer can reference your earlier answers.

This wasn't just passing data around. I had to structure it so later rounds get context without seeing scores or hiring recommendations. The handoff data gets injected into the prompt for the next round, making the conversation feel continuous and natural.

### Coding Workspace

For the coding rounds, I integrated Monaco Editor with a custom wrapper. Candidates get a full IDE experience with tabs, timers, and a built-in test runner. The problems are stored in `coding-problems.ts` with test cases, and I built a Python worker (`python-worker.ts`) that executes the code in a sandboxed environment.

The code execution was tricky. I needed to run Python code safely, capture output, handle errors, and run test cases. The worker processes submissions and returns results that get displayed in real-time. I also track coding telemetry—things like how long someone takes, how many times they run tests, and their approach to solving problems.

### Dashboard & Data Management

I built a full dashboard with views for jobs, candidates, transcripts, and reports. Since this was a hackathon project, I used an in-memory store (`store.ts`) to keep things simple. It works for demos, but I'd need to swap it out for a real database in production.

The dashboard shows an activity feed, a pipeline view of candidates at different stages, and radar charts for skills assessment. I also built components for creating jobs, viewing candidate profiles, and generating scorecards from the interview data.

### API Routes

The backend is all Next.js API routes. `/api/interview/session` handles token generation and prompt injection. `/api/interview/analyze` scores rounds and generates insights. `/api/interview/handoff` manages the context passing between rounds. And `/api/resume/parse` is a stubbed parser that feeds candidate data into the dashboard.

### The Challenge

Building this in 17 hours meant making a lot of quick decisions. I prioritized getting the voice integration working first, since that was the core differentiator. Then I built out the round system and handoff logic. The coding workspace came next, and I finished with the dashboard and polish.

The hardest part was debugging the audio pipeline. Getting the format conversions right, handling WebSocket reconnections, and making sure the conversation flow felt natural took a lot of iteration. But once the voice was working, everything else fell into place pretty quickly.

Looking back, I'm pretty happy with how it turned out. The architecture is clean enough that I could extend it easily, and the handoff system makes the whole interview feel like one cohesive conversation rather than three separate rounds.

## What's Next

I'm excited to keep going. If you're working on applied LLMs, voice agents, or developer tools and think I could be a fit for your team, I'd love to connect.

You can check out the code:
- [GitHub Repository](https://github.com/ashikshafi08/interview-platform)

The project is built with Next.js 16, React 19, and XAI's realtime API. It's set up for Vercel deployment, though I'm still working on replacing the in-memory store with a proper database before putting it into production.

Overall, it was one of the best experiences I've had. Building something meaningful in 17 hours, surrounded by talented people, and getting to work with cutting-edge AI tools—that's what keeps me coming back to these events.

