---
layout: page
title: Grok Interviewer
description: An AI-powered interview simulator built at the xAI Hackathon that stitches together HR, technical, and coding rounds with shared context using Grok Voice.
img: assets/img/xai-elon.jpg
importance: 0.5
category: AI/ML
github: https://github.com/ashikshafi08/interview-platform
---

<div class="row">
    <div class="col-sm mt-3 mt-md-0">
        {% include figure.html path="assets/img/xai-elon.jpg" title="xAI Hackathon" class="img-fluid rounded z-depth-1" %}
    </div>
</div>

## Overview

Built **Grok Interviewer** in 17 hours at the xAI Hackathon—a conversational AI that interviews candidates naturally over voice and turns sessions into structured content. The platform stitches together HR, technical, and coding rounds with a shared context, creating a seamless interview experience.

## Key Features

- **Multi-Round Voice Interviews**: Powered by XAI's realtime API with persona-specific prompts for HR, technical, and coding rounds
- **Monaco-Based Coding Workspace**: Full IDE experience with timers, tabs, and built-in test runner for live coding assessments
- **Context Handoff Pipeline**: Carries discussion topics, claims, and follow-ups between rounds without leaking scores
- **Automated Scorecards**: Generates insights and evaluations after each round
- **Dashboard Views**: Complete views for jobs, candidates, transcripts, and reports

## Technical Implementation

### Voice Integration

The core innovation is the voice integration using XAI's realtime API. I built custom React hooks (`use-interview-voice` and `use-interview-audio`) to handle the entire audio lifecycle. The browser captures audio as PCM16, but XAI's API needs Float32, so I wrote conversion utilities to transform the audio stream in real-time.

### Round Handoff System

One of the coolest features is the handoff between rounds. The system captures key discussion points, claims the candidate made, and follow-up questions from each round. When you move to the technical round, the interviewer already knows what you talked about in HR. The handoff data gets injected into the prompt for the next round, making the conversation feel continuous and natural.

### Coding Workspace

For coding rounds, I integrated Monaco Editor with a custom wrapper. Candidates get a full IDE experience with tabs, timers, and a built-in test runner. The problems are stored with test cases, and I built a Python worker that executes code in a sandboxed environment, tracking coding telemetry like time taken and approach.

## Technologies Used

- **Frontend**: Next.js 16, React 19, TypeScript
- **Voice**: XAI Realtime API, WebSocket connections
- **Editor**: Monaco Editor (VS Code editor)
- **Backend**: Next.js API routes
- **Execution**: Python worker for code execution
- **Deployment**: Vercel-ready

## Hackathon Experience

Built this entirely solo in 17 hours at the xAI office, working with tools and features that weren't even public yet. The hardest part was debugging the audio pipeline—getting format conversions right, handling WebSocket reconnections, and making sure the conversation flow felt natural.

## Demo

{% include video.html path="https://www.youtube.com/embed/w2ZOxkmLqt8" caption="Demo of Grok Interviewer" max-width="100%" %}

## Links

- [GitHub Repository](https://github.com/ashikshafi08/interview-platform)

