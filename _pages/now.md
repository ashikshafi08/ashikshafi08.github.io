---
layout: page
title: now
permalink: /now/
description: What I'm currently working on and thinking about.
nav: true
nav_order: 2
---

This is my [now page](https://nownownow.com/about) - a snapshot of what I'm focused on.



- **@Dec 15, 2025** - Travelling to San Francisco for [DevHouse SF](https://devhouse.devlabs.club/). First time going to a hacker house, and I'm excited to spend the next 7 days building what I love.



---

<div class="now-entries">
  {% if site.now.enabled %}
  {% assign now_entries = site.now | sort: 'date' | reverse %}
  {% for entry in now_entries limit: site.now.limit %}
  <div class="now-entry">
    <div class="now-date">{{ entry.date | date: "%b %d" }}</div>
    <div class="now-content">
      <strong>{{ entry.title }}</strong>
      {{ entry.content }}
    </div>
  </div>
  {% endfor %}
  {% else %}
  <p>No updates yet...</p>
  {% endif %}
</div>
