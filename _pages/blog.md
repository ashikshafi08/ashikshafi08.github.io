---
layout: default
permalink: /blog/
title: blog
nav: true
nav_order: 1
pagination:
  enabled: true
  collection: posts
  permalink: /page/:num/
  per_page: 10
  sort_field: date
  sort_reverse: true
---

<div class="blog-minimal">

  <div class="blog-filters">
    {% for category in site.display_categories %}
      <a href="{{ category | slugify | prepend: '/blog/category/' | relative_url }}">{{ category }}</a>
    {% endfor %}
  </div>

  <ul class="post-list-minimal">
    {%- if page.pagination.enabled -%}
      {%- assign postlist = paginator.posts -%}
    {%- else -%}
      {%- assign postlist = site.posts -%}
    {%- endif -%}

    {% for post in postlist %}
    <li>
      <span class="post-date">{{ post.date | date: '%b %Y' }}</span>
      <a href="{{ post.url | relative_url }}">{{ post.title }}</a>
    </li>
    {% endfor %}
  </ul>

  {%- if page.pagination.enabled -%}
    {%- include pagination.html -%}
  {%- endif -%}

</div>
