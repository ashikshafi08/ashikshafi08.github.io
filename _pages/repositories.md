---
layout: page
permalink: /repositories/
title: repositories
description: A collection of my projects and contributions
nav: true
nav_order: 4
---

<div class="clean-repositories">
  {% if site.data.repositories.github_repos %}
  <div class="projects-grid">
    {% for repo in site.data.repositories.github_repos %}
      {% include repository/repo_clean.html repository=repo %}
    {% endfor %}
  </div>
  {% endif %}
</div>
