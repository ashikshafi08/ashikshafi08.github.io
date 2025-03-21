---
layout: page
title: PubMed 200k RCT Implementation
description: A deep learning model for classifying sentences in medical abstracts using advanced NLP techniques.
img: assets/img/projects/pubmed.png
importance: 3
category: AI/ML
---

<div class="row">
    <div class="col-sm mt-3 mt-md-0">
        {% include figure.html path="assets/img/projects/pubmed.png" title="PubMed Classification System" class="img-fluid rounded z-depth-1" %}
    </div>
</div>

## Overview

Implemented a sophisticated deep learning model to classify sentences in medical abstracts into distinct categories (BACKGROUND, METHODS, RESULTS), achieving **87.31%** accuracy. The project demonstrates advanced NLP techniques for medical text analysis.

## Technical Architecture

### Model Components
- **Embedding Layer**: 
  - Token embeddings for word-level features
  - Character embeddings for sub-word information
  - Positional encodings for sequence context

### Implementation Details
```python
class MedicalAbstractClassifier(nn.Module):
    def __init__(self, vocab_size, embed_dim):
        super().__init__()
        self.embedding = nn.Embedding(vocab_size, embed_dim)
        self.bilstm = nn.LSTM(
            input_size=embed_dim,
            hidden_size=128,
            bidirectional=True,
            batch_first=True
        )
        self.classifier = nn.Linear(256, num_classes)
```

## Key Features

- **Hybrid Embedding Approach**:
  - Combined token and character-level features
  - Enhanced contextual understanding
  - Robust to medical terminology

- **BiLSTM Architecture**:
  - Bidirectional context processing
  - Effective sequence modeling
  - Optimized for medical text

- **Performance Metrics**:
  - Accuracy: 87.31%
  - Robust cross-validation
  - Strong F1-score across categories

## Technologies Used

- **Core Framework**: TensorFlow 2.x
- **Architecture**: Bidirectional LSTM
- **NLP Components**: Custom embeddings, tokenization
- **Evaluation**: Scikit-learn metrics
- **Data Processing**: Pandas, NumPy

Every project has a beautiful feature showcase page.
It's easy to include images in a flexible 3-column grid format.
Make your photos 1/3, 2/3, or full width.

To give your project a background in the portfolio page, just add the img tag to the front matter like so:

    ---
    layout: page
    title: project
    description: a project with a background image
    img: /assets/img/12.jpg
    ---

<div class="row">
    <div class="col-sm mt-3 mt-md-0">
        {% include figure.html path="assets/img/1.jpg" title="example image" class="img-fluid rounded z-depth-1" %}
    </div>
    <div class="col-sm mt-3 mt-md-0">
        {% include figure.html path="assets/img/3.jpg" title="example image" class="img-fluid rounded z-depth-1" %}
    </div>
    <div class="col-sm mt-3 mt-md-0">
        {% include figure.html path="assets/img/5.jpg" title="example image" class="img-fluid rounded z-depth-1" %}
    </div>
</div>
<div class="caption">
    Caption photos easily. On the left, a road goes through a tunnel. Middle, leaves artistically fall in a hipster photoshoot. Right, in another hipster photoshoot, a lumberjack grasps a handful of pine needles.
</div>
<div class="row">
    <div class="col-sm mt-3 mt-md-0">
        {% include figure.html path="assets/img/5.jpg" title="example image" class="img-fluid rounded z-depth-1" %}
    </div>
</div>
<div class="caption">
    This image can also have a caption. It's like magic.
</div>

You can also put regular text between your rows of images.
Say you wanted to write a little bit about your project before you posted the rest of the images.
You describe how you toiled, sweated, *bled* for your project, and then... you reveal its glory in the next row of images.


<div class="row justify-content-sm-center">
    <div class="col-sm-8 mt-3 mt-md-0">
        {% include figure.html path="assets/img/6.jpg" title="example image" class="img-fluid rounded z-depth-1" %}
    </div>
    <div class="col-sm-4 mt-3 mt-md-0">
        {% include figure.html path="assets/img/11.jpg" title="example image" class="img-fluid rounded z-depth-1" %}
    </div>
</div>
<div class="caption">
    You can also have artistically styled 2/3 + 1/3 images, like these.
</div>


The code is simple.
Just wrap your images with `<div class="col-sm">` and place them inside `<div class="row">` (read more about the <a href="https://getbootstrap.com/docs/4.4/layout/grid/">Bootstrap Grid</a> system).
To make images responsive, add `img-fluid` class to each; for rounded corners and shadows use `rounded` and `z-depth-1` classes.
Here's the code for the last row of images above:

{% raw %}
```html
<div class="row justify-content-sm-center">
    <div class="col-sm-8 mt-3 mt-md-0">
        {% include figure.html path="assets/img/6.jpg" title="example image" class="img-fluid rounded z-depth-1" %}
    </div>
    <div class="col-sm-4 mt-3 mt-md-0">
        {% include figure.html path="assets/img/11.jpg" title="example image" class="img-fluid rounded z-depth-1" %}
    </div>
</div>
```
{% endraw %}
