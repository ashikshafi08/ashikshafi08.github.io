---
layout: page
title: Log
permalink: /log/
description: A log of my recent work and achievements.
nav: true
nav_order: 5
---

<div class="log">
  {% if site.logs.enabled %}
  {% for log in site.log reversed %}
  <div class="log-item">
    <h3 class="title">{{ log.title }}</h3>
    <p class="date">{{ log.date | date: "%B %-d, %Y" }}</p>
    {{ log.content }}
    <hr>
  </div>
  {% endfor %}
  {% else %}
  <p>No logs yet...</p>
  {% endif %}
</div> 