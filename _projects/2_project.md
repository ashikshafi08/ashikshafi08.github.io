---
layout: page
title: Open Source Contributions
description: Significant contributions to major open-source projects including Bittensor, PyTorch Vision, and other AI/ML frameworks.
img: assets/img/projects/opensource.png
importance: 2
category: Open Source
---

<div class="row">
    <div class="col-sm mt-3 mt-md-0">
        {% include figure.html path="assets/img/projects/opensource.png" title="Open Source Contributions" class="img-fluid rounded z-depth-1" %}
    </div>
</div>

## Overview

Made significant contributions to major open-source projects in the AI/ML ecosystem, focusing on performance optimization and bug fixes. My work spans across several key projects in the machine learning infrastructure space.

## Key Contributions

### Bittensor Network
- **Critical Bug Fix**: Patched a double conversion bug in stake swap functionality
- **Impact**: Prevented potential stake amount inflation issues
- **Example**: Fixed incorrect conversions like 21.5 billion from 21.5369

### PyTorch Vision
- **Performance Optimization**: Refactored LAMB optimizer implementation
- **Impact**: Achieved 15% faster training speed on large datasets
- **Scope**: Core optimizer functionality enhancement

### Mosaic Commune
- **Architecture**: Designed and implemented image generation pipeline
- **Focus**: Speed and reliability improvements
- **Integration**: Seamless workflow with existing systems

### Synthia Subnet
- **System Overhaul**: Revamped leaderboard system
- **Performance**: Reduced load time from 50+ seconds to under 5 seconds
- **Scale**: Optimized for 500+ daily users
- **Technology**: Implemented using aiohttp and asyncio for better concurrency

## Technical Details

```python
# Example of the optimized async leaderboard implementation
async def fetch_leaderboard_data():
    async with aiohttp.ClientSession() as session:
        tasks = [fetch_user_stats(session, user_id) for user_id in user_ids]
        return await asyncio.gather(*tasks)
```

## Technologies Used

- **Languages**: Python, AsyncIO
- **Frameworks**: PyTorch, PyTorch Lightning
- **Performance**: Profiling, Optimization
- **Architecture**: Distributed Systems, Async Programming
