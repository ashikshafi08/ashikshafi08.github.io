---
layout: page
title: MapOps
description: A conversational city analyst AI agent built at YC Agents Hackathon that understands natural language and acts on maps to help people explore cities.
img: assets/img/yc-agent-front-row.jpeg
importance: 1.5
category: AI/ML
github: https://github.com/ashikshafi08/mapops
---

<div class="row">
    <div class="col-sm mt-3 mt-md-0">
        {% include figure.html path="assets/img/yc-agent-front-row.jpeg" title="YC Agents Hackathon" class="img-fluid rounded z-depth-1" %}
    </div>
</div>

## Overview

Built **MapOps** in 18 hours solo at the YC Agents Hackathon—a map-based AI agent that understands natural language and acts on maps to help people explore cities, decide where to go, and discover places tailored to their preferences.

## Key Features

- **Interactive Google Maps Integration**: Full map view with markers, info windows, and real-time updates
- **Natural Language Query Processing**: Understands conversational requests like "quiet cafés near me" or "best Italian restaurants within walking distance"
- **Comprehensive API Integration**: Places API, Routes API, Places Aggregate API, Geocoding API, and Roads API
- **Walking Distance Calculations**: Accurate walking times using Routes API, not just straight-line distance
- **Place Aggregation**: Density analysis, counting places by type, finding high-density zones
- **Route Optimization**: Multi-stop route planning and optimization

## Technical Implementation

### Mastra Framework

I used **Mastra** framework to structure the entire agent system. Instead of building agent logic from scratch, Mastra provided the architecture for tool definitions, agent orchestration, and LLM integration. I created a `cityAnalystAgent` with a comprehensive set of tools:

- `search-places.ts` - Natural language place search
- `get-place-details.ts` - Detailed place information
- `get-directions.ts` - Route calculation
- `geocode.ts` - Address to coordinates conversion
- `calculate-distance-matrix.ts` - Walking times and distances
- `navigate-to-place.ts` - Map navigation
- `map-control.ts` - Map zoom, pan, and view control
- `trip-plan.ts` - Multi-stop trip planning
- And more...

### Google Maps Platform

The core is built on Google Maps Platform APIs. Each API gets its own service module with proper error handling and type safety. The system coordinates between multiple APIs—like searching for places, then calculating walking distances, then filtering results.

### Natural Language Processing

With Mastra, the NLP layer became seamless. The LLM (through Mastra) handles natural language understanding, automatically selecting the right tools, extracting parameters, and chaining multiple tools together based on user queries.

## Technologies Used

- **Frontend**: Next.js, TypeScript, React
- **Agent Framework**: Mastra
- **Maps**: Google Maps JavaScript API, Places API, Routes API, Geocoding API
- **Protocol**: MCP (Model Context Protocol)
- **Deployment**: Vercel-ready

## Hackathon Experience

Built this entirely solo in 18 hours at the YC office after my teammates didn't show up. Going solo was actually liberating—no team coordination overhead, just pure building. I could make decisions instantly and pivot quickly when something wasn't working.

## Links

- [GitHub Repository](https://github.com/ashikshafi08/mapops)

