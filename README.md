# maine-thesis
A LaTeX class file for the typesetting of Masters and Doctorate Theses at the University of Maine.

## Installation

To install this class file simply copy or link `maine-thesis.cls` to your texmf tree.  On Unix based systems one of the following commands should work:

``cp maine-thesis.cls `kpsewhich --var-value TEXMFHOME```

``ln maine-thesis.cls `kpsewhich --var-balue TEXMFHOME```

The advantage to linking over copying is that once you've set this up, you need only use `git fetch` to make updates (assuming you keep your clone of the repository).

## Documentation

The files in the Documentation folder serve both as the documentation for this class file and as an example of its use.

## skeleton

The skeleton folder contains a basic document structure which you can use as a template for your own these.