ntu_thesis_template
===================

The template for NTU thesis

General information
* If you have any questions, just let me know.
* If you find better latex package than that I used, please update it and let me know

Compilation

* Build thesis 
<pre>
make TARGET=XXX
</pre>
  - Example: 
  <pre>
    make TARGET=00_Titlepage
  </pre>
  This command will only build 00_Titlepage.pdf

  - If the TARGET is not prespecified, its default value is Thesis
  <pre>
    make
  </pre>
  This command will build the Thesis.pdf
