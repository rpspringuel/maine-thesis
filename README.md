# maine-thesis
A LaTeX class file for the typesetting of a Masters or Doctorate Thesis at the University of Maine (Orono, ME).

## Installation

To install this class file simply copy or link `maine-thesis.cls` to your texmf tree.  On Unix based systems one of the following commands should work:

`cp maine-thesis.cls $(kpsewhich --var-value TEXMFHOME)`

`ln maine-thesis.cls $(kpsewhich --var-value TEXMFHOME)`

On Windows machines the equivalent commands are:

``for /f "usebackq tokens=*" %a in (`kpsewhich --var-value TEXMFHOME`) do copy maine-thesis.cls %a``

``for /f "usebackq tokens=*" %a in (`kpsewhich --var-value TEXMFHOME`) do mklink %a maine-thesis.cls``

The advantage to linking over copying is that once you've set this up, you need only use `git fetch` to make updates, but you do have to keep your copy of the repository.

## Repository inventory:

Besides the class file itself, this repository contains the following additional resources:

### Documentation

The files in the Documentation folder serve both as the documentation for this class file and as an example of its use.

### skeleton

The skeleton folder contains a basic document structure which you can use as a template for your own thesis.

### Thesisguidelines.pdf

This is the latest copy of the [official thesis guidelines](https://umaine.edu/graduate/resource/thesis-guidelines/) published by the Graduate School at the University of Maine.  The class file is intended to implement these guidelines as faithfully as possible.  However, there have been instances where the Graduate School has modified their guidelines without updating this document.  Unfortunately, you'll usually find out about these changes when the Graduate School asks for changes before accepting your thesis.  If this happens to you, please let me know and I will update the class file accordingly.

## Contributing

If you find a bug in the class file or something that it doesn't format correctly, please contact either by posting an issue here on [GitHub](https://github.com/rpspringuel/maine-thesis/issues) or by [emailing me](mailto:rpspringuel@gmail.com).  If emailing me please include `maine-thesis` in your subject line in order to avoid spam filters.

Also, when reporting a bug or something that needs to be changed a MWE that demonstrates the current unacceptable behavior and a picture or complete description of the desired result is really useful.
