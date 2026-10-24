+++
date = '2026-10-24T14:08:07+05:30'
draft = false
title = 'Pixels, Polish, and Progress: My UI Revamp'
description = 'I rebuilt my Hugo blog around one column, two typefaces, and no JavaScript. A local model did most of the typing.'
tags = ['hugo', 'design', 'llm']
+++

The old blog worked. That was the problem.

It had a navigation bar, an icon font, share buttons, and seven stylesheets. None of it was broken. But every element was asking for attention, and none of it was the writing.

So I threw out the front end and started again. Same Hugo site, same URLs, same static output. The new version follows a much shorter list of rules.

## Two blogs I kept open

[drewdevault.com](https://drewdevault.com/) is the reason I stopped being afraid of a page with almost nothing on it. No cards, no thumbnails, no hamburger menu. A date, a title, and the post. It loads instantly because there is almost nothing to load, and it looks like a person's site rather than a product.

[fzakaria.com](https://fzakaria.com/) takes the same idea in a different direction: careful typography, a narrow measure, code blocks that are actually readable. The design is mostly a set of decisions about spacing, and it disappears while you read.

I stole from both. From the first, the confidence to remove things. From the second, the patience to set type properly.

## The rules

I wrote the constraints before I wrote any CSS:

- **One column.** The prose measure is fixed at `36rem` and never grows, even on a large display. The margins get wider instead. A line of text should be a comfortable length, not the full width of the monitor.
- **Two typefaces.** Newsreader for prose, JetBrains Mono for anything structural: dates, labels, captions, code. Serif to read, mono to orient.
- **No JavaScript.** Not a framework, not a theme toggle, not an analytics snippet. The page is HTML and CSS.
- **No third-party requests.** Fonts are self-hosted and preloaded, so there is no extra DNS lookup and TLS handshake before the first paint.
- **Light and dark come from the OS.** No switch, no `localStorage`, no flash of the wrong theme.
- **Every element has to earn its place.** If it is not the post, it needs a reason to exist.

That last rule did most of the work.

## What it looks like now

On a wide screen the page has three zones: a narrow left gutter where section markers hang, the prose column, and a right margin that holds a short bio card on the index. Below the breakpoint the margins collapse and the page becomes a single column. Nothing is hidden. Things just move.

Headings get a small section mark in the gutter that links to the section. It stays out of the reading path until you want it, and on a phone it sits inline instead of vanishing.

The archive is grouped by year. The newest post gets a lead card with its opening lines. Dates, tags, and reading time are set in mono so they read as metadata rather than prose. In CI, the footer links to the exact commit the build came from, which is either useful or accountability, depending on the day.

Dark mode is the same page with a different palette: deep navy paper, off-white ink, a lighter cobalt. One accent color does the work: links, list markers, the rule under the title. That is the whole color system.

The unglamorous parts are there too: a skip link, visible focus rings, support for reduced motion, and a print stylesheet. They are not features anyone notices, which is the point.

## One deliberately useless thing

Every page has a spectrum under the masthead: 32 mirrored bars on a faint center line, fading from cobalt to nothing across the width. It is the SHA-256 digest of the page's URL path. One bar per byte, height taken from the byte's value. The same path always draws the same spectrum, so every page has a mark that belongs only to it.

It is generated at build time by a Hugo partial, as inline SVG with a gradient. No canvas, no JavaScript, no image request. A blog with no decoration at all can start to feel like a man page; this is the one thing on the page that exists purely because I like it.

## The slop machine

I have been calling this project the slop machine. The name does two jobs: it keeps me honest about how much of the code I did not write, and it stops the model from taking credit for the taste.

The setup:

- DeepSeek's agent harness, driving the edits
- [llama.cpp](https://github.com/ggml-org/llama.cpp) serving the model locally
- Qwen3.8-27B, `Q4_K_XL` quantized GGUF, from [Unsloth](https://huggingface.co/unsloth)

Everything ran on my machine. No API keys, no token bill, no source code leaving the laptop.

What actually happened: I described what I wanted, the model wrote templates and stylesheets, and then I opened the browser and said no. A lot.

Local models are good at the tedious parts of front-end work: another layout variant, a rename across templates, a media query that has to exist because Safari exists. At `Q4` the model is fast enough that trying three approaches costs less than arguing with myself about one.

It is bad at restraint. Left alone it will add a second accent color, a card shadow, a hover lift, and a gradient nobody asked for. It will also invent Hugo template functions that do not exist and cheerfully delete a partial it has decided is redundant. The quantized model is confidently wrong in the same way the big hosted models are, only faster and free.

So the loop was simple: prompt, render, reject. The model typed; I decided. Most of the design is in what I removed.

## What I would tell myself

- **Constraints are the design.** "Make it modern" produces slop. "Two fonts, one column, no JavaScript" produces a site.
- **Set the type first.** Measure, size, and line height will do more for a page than any component you can add later.
- **Delete until it hurts, then delete one more thing.** The navbar was the best thing I removed.
- **Keep one useless detail.** It is what makes the page yours instead of the theme's.
- **Test the boring states.** Dark mode, a 320px screen, print, keyboard focus, reduced motion. That is where templates fall apart.

## The result

The site is still Hugo: one stylesheet pipeline, a handful of partials, no JavaScript, and a build that finishes before I can switch windows. The URLs did not change. The posts are still the same posts.

The point was never the redesign. It was to make the writing the most interesting thing on the page. This post is the first real test. If the design works, you stopped noticing it a few paragraphs ago.
