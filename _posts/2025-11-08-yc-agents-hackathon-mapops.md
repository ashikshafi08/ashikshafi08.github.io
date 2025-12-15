---
layout: post
title: "Building MapOps Solo at YC Agents Hackathon"
date: 2025-11-08
description: My first time in San Francisco, going solo at the YC Agents Hackathon, and building a conversational city analyst AI agent that understands maps
tags: ai hackathon yc agents maps google-maps
categories: projects
---

First time in San Francisco. First time at a YC hackathon. First time going completely solo because my teammates bailed on me. But you know what? Sometimes the best builds happen when you just say fuck it and go solo.

{% include figure.html path="assets/img/selfie-near-yc-off.jpeg" caption="Near the YC office before the hackathon" max-width="100%" %}

I flew in from Chicago for the YC Agent Jam '25 Hackathon. I'd committed to a team on Discord—you know how it goes, everyone's excited online, making plans, talking about what we'd build. Then I show up at the YC office and... nobody's there. People committed to be on the team but in real life, no one showed up. Classic.

So I had a choice: spend time trying to find a new team, or just build something myself. I chose the latter.

## Why MapOps?

I've always loved maps. There's something fascinating about how we navigate the world, how we understand space, how we make decisions about where to go. And I've been thinking a lot about AI agents—what if we could give them the same tools humans use to navigate and explore cities? What if an AI could understand natural language queries about places and actually act on maps like we do?

That's how MapOps was born. A conversational city analyst that understands natural language and acts on maps to help people explore cities, decide where to go, and discover places tailored to their preferences.

{% include figure.html path="assets/img/yc-agent-front-row.jpeg" caption="At the YC Agents Hackathon" max-width="100%" %}

## Building in the YC Office

I spent 18 hours building this thing, right there in the YC office. The energy was incredible—people working on all sorts of agent projects, everyone pushing boundaries. I was in the front row, headphones on, just coding.

The core idea was simple: take Google Maps Platform APIs and wrap them in a way that makes sense for AI agents. I integrated everything—Places API, Routes API, Places Aggregate API, Geocoding API, Roads API. The agent could search for places using natural language, calculate walking distances, find routes, analyze place density, and more.

I built it with TypeScript, using Google Maps JavaScript API for the interactive map view. The architecture is clean—separate services for each API, a main app orchestrator, and a natural language query processor that translates user requests into map actions.

The hardest part was making the natural language processing work smoothly. Users should be able to say things like "find quiet cafés within walking distance" or "show me the best restaurants near here" and have the agent understand and act on it. I had to build query parsing that could extract intent, location preferences, filters, and then translate that into the right API calls.

{% include figure.html path="assets/img/yc-door-dash.jpeg" caption="YC office vibes" max-width="100%" %}

## What I Built

MapOps ended up being a comprehensive map-based AI agent with:

- **Interactive Google Maps view** - Full map integration with markers and info windows
- **Natural language query processing** - Understands conversational requests about places
- **Place search and filtering** - Text search, nearby search, filtering by rating, price, open status
- **Walking distance calculations** - Routes API integration for accurate walking times
- **Real-time location detection** - Geolocation service for user's current position
- **Place aggregation** - Density analysis, counting places by type, finding high-density areas
- **Route optimization** - Multi-stop route planning and optimization

All of this wrapped in a clean interface where you can just talk to the map like you would talk to a friend about where to go.

## How I Built It

I built this entire thing in 18 hours, solo, in the YC office. Here's how it came together:

### Tech Stack

I went with **TypeScript** for type safety and better developer experience. For the agent architecture, I used **Mastra**—a framework for building AI agents that made it way easier to structure the whole thing. The frontend has two parts: a vanilla TypeScript version with Google Maps JavaScript API (in the root `src/` folder), and a Next.js frontend with Mastra integration (in `nextjs-frontend/`).

The architecture is service-based. Each Google Maps API gets its own service module:
- `places-service.ts` - Handles place search, details, autocomplete
- `routes-service.ts` - Route calculation, distance matrix, optimization
- `places-aggregate-service.ts` - Place aggregation and density analysis
- `geocoding-service.ts` - Address to coordinates conversion
- `roads-service.ts` - Road snapping and speed limits
- `geolocation-service.ts` - User location detection

### Google Maps Integration

The core is the Google Maps JavaScript API. I built `map-setup.ts` to handle map initialization, marker management, and info windows. The map renders in a full-screen container, and markers update dynamically based on search results.

The tricky part was managing all the different API calls and keeping the UI responsive. I had to handle async operations, error states, and loading indicators. Each service is a class that wraps the Google Maps API calls with proper error handling and type safety.

### Mastra Framework Integration

This is where Mastra really shined. Instead of building the agent logic from scratch, I used Mastra to structure the whole agent system. I created a `cityAnalystAgent` that uses Mastra's agent builder, and then defined a bunch of tools that the agent can use.

The tools are all in `nextjs-frontend/mastra/tools/`:
- `search-places.ts` - Search for places using natural language
- `get-place-details.ts` - Get detailed information about a specific place
- `get-directions.ts` - Calculate routes between locations
- `geocode.ts` - Convert addresses to coordinates
- `calculate-distance-matrix.ts` - Get walking times and distances
- `navigate-to-place.ts` - Navigate the map to a specific location
- `map-control.ts` - Control map zoom, pan, and view
- `map-observe.ts` - Observe what's currently visible on the map
- `trip-plan.ts` - Plan multi-stop trips
- `search-along-route.ts` - Find places along a route
- And more...

Each tool is a Mastra tool definition with proper schemas, descriptions, and handlers. The agent can automatically decide which tools to use based on the user's query. Mastra handles the tool calling, parameter extraction, and execution flow.

The agent itself is defined in `cityAnalystAgent.ts` with a system prompt that describes its role as a city analyst. It has access to all the tools, and Mastra's runtime handles the orchestration—figuring out which tools to call, in what order, and how to combine the results.

I also set up MCP (Model Context Protocol) configuration, which allows the agent to work with external tools and services. This made it easy to integrate with the Google Maps APIs and keep the tool definitions clean and modular.

### Natural Language Processing

With Mastra, the NLP layer became way simpler. Instead of building a custom parser, the LLM (through Mastra) handles the natural language understanding. Users can say things like "quiet cafés near me" or "best Italian restaurants within walking distance" and the agent:

1. Understands the intent using the LLM
2. Selects the right tools (search-places, get-directions, etc.)
3. Extracts parameters from the query
4. Calls the tools in sequence
5. Combines results into a natural response

Mastra's tool system made this seamless. The agent can chain multiple tools together—like searching for places, then getting directions, then calculating walking times—all based on what the user asked for. The LLM handles the reasoning about which tools to use and how to interpret the results.

### Walking Distance Calculations

One of the cool features is walking distance filtering. When someone asks for places "within walking distance," the system:
1. Gets the user's current location
2. Searches for places in the area
3. Uses Routes API to calculate actual walking times
4. Filters results to only show places within a reasonable walking distance (like 15-20 minutes)

This required coordinating between the Places API and Routes API, handling multiple async calls, and aggregating the results. The Routes API gives accurate walking times based on actual paths, not just straight-line distance.

### Place Aggregation

I integrated the Places Aggregate API to do density analysis. The system can count places by type in an area, find high-density zones, and provide insights like "this area has the most restaurants" or "cafés are concentrated in this neighborhood."

This was useful for queries like "where are most of the coffee shops?" or "show me areas with lots of restaurants." The aggregate API is powerful but requires careful parameter tuning to get useful results.

### Info Windows and UI

I built custom info windows (`info-window.ts`) that show place details, ratings, prices, and walking distances. The UI updates in real-time as users interact with the map. Markers are color-coded by place type, and clicking a marker shows detailed information.

The whole thing runs in a single HTML page with the map taking up most of the screen. There's a search bar at the top for natural language queries, and results appear as markers on the map with info windows.

### The Solo Build Experience

Building this solo was actually great. No discussions about architecture, no waiting for code reviews, just pure execution. I could make decisions instantly and pivot quickly when something wasn't working.

The 18 hours flew by. I spent the first few hours setting up the Google Maps integration and basic services. Then I built the NLP parser and query processing. The last few hours were polish—info windows, error handling, and making sure everything worked smoothly together.

The code is clean and well-structured. Each service is independent, so you could easily swap out implementations or add new features. The TypeScript types make it easy to understand what each function expects and returns.

## The 5-Hour SF Speed Run

After the hackathon ended, I had about 5 hours before my flight back to Chicago. I wasn't about to leave San Francisco without seeing at least a few things, so I did a speed run.

First stop: Golden Gate Bridge. I had to see it. Walked across part of it, took some photos. It's as impressive in person as you'd expect.

{% include figure.html path="assets/img/sf-golden-gate-selfie.jpeg" caption="Golden Gate Bridge selfie" max-width="100%" %}

Then I hit Fisherman's Wharf. Got fish and chips because, you know, when in Rome. It was... meh. Not terrible, but not great either. The view was nice though.

{% include figure.html path="assets/img/sf-waymo.jpeg" caption="Waymo self-driving car in SF" max-width="100%" %}

I also saw a Waymo self-driving car, which was cool. Felt very San Francisco—tech everywhere, even on the streets.

Then it was back to the airport and home to Chicago, the most beautiful city in the world. Don't @ me.

## Lessons Learned

Going solo at a hackathon was actually liberating. No team coordination overhead, no waiting for others, just pure building. I could make decisions fast and iterate quickly. Sometimes the best teams are teams of one.

The project is open source on GitHub. I'm pretty happy with how it turned out—it's a solid foundation for building map-aware AI agents. The architecture is clean, the API integrations are comprehensive, and the natural language processing works well.

You can check it out here: [MapOps on GitHub](https://github.com/ashikshafi08/mapops)

San Francisco was cool, but I'm happy to be back in Chicago. There's something about building something meaningful, even if you're doing it alone, that makes the whole trip worth it. And hey, at least I got to see the Golden Gate Bridge.

