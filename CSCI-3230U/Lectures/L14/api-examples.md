---
title: "PaperBeam API Reference"
---

# PaperBeam API Reference

Below is a structured overview of the **PaperBeam** API, listing its core functions, parameters, return values, and the primary configuration fields. This document follows a typical layout reference style for a VitePress site.

[[toc]]

## PaperBeam Object

*`PaperBeam.init(selector, config)`*

Initializes the PaperBeam layout engine.

- **Parameters**  
  - `selector` **(string)** – A valid CSS selector (e.g. `"#app"`) targeting the element(s) to be managed by PaperBeam.  
  - `config` **(Object)** – An object that defines layout behavior, theming, and optional advanced features.

- **Returns**
  - **(Object)** – A reference to the new PaperBeam instance.

**Example**  
```js
  PaperBeam.init('#app', {
    columns: { minWidth: 250, maxWidth: 400, gap: 16 },
    theme: 'default',
    userContext: true
  });
```