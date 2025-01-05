## Multiple Choice Questions:

### Section 1: Bioinformatics File Formats and Parsing

1. What is the primary purpose of the FASTA file format?
   - a) Storing genomic annotations
   - b) Storing nucleotide or amino acid sequences
   - c) Storing quality scores of sequencing reads
   - d) Storing raw sequencing data

2. Which file format includes both nucleotide sequences and their quality scores?
   - a) FASTA
   - b) FASTQ
   - c) GFF
   - d) BAM

3. The GFF file format is primarily used for:
   - a) Storing sequence alignment data
   - b) Storing feature annotations for genomes
   - c) Storing raw nucleotide sequences
   - d) Storing protein structure data

4. Which of the following is not a bioinformatics file format?
   - a) SAM
   - b) FASTA
   - c) XLSX
   - d) GTF

5. What is the advantage of using the FASTQ format over FASTA?
   - a) It includes quality scores for each sequence
   - b) It is compressed for storage
   - c) It supports protein sequences
   - d) It provides annotation data

6. Which of the following Python libraries is commonly used for parsing bioinformatics file formats?
   - a) Matplotlib
   - b) Biopython
   - c) NumPy
   - d) SciPy

7. A GTF file differs from a GFF file in that it:
   - a) Is binary while GFF is text-based
   - b) Contains additional standardized attributes
   - c) Stores quality scores for sequences
   - d) Is used only for RNA sequences

8. What does a header line in a FASTA file start with?
   - a) @
   - b) >
   - c) #
   - d) $

9. In bioinformatics, "parsing" refers to:
   - a) Generating random sequences
   - b) Extracting and interpreting data from files
   - c) Compressing genomic data
   - d) Aligning sequences

10. Which tool is commonly used for sequence alignment?
    - a) BLAST
    - b) Matplotlib
    - c) SciPy
    - d) NumPy

### Section 2: Data Visualization with Matplotlib

11. What is the purpose of the `%matplotlib inline` magic command?
    - a) Importing Matplotlib into a script
    - b) Displaying plots within a Jupyter Notebook
    - c) Enabling 3D plotting in Matplotlib
    - d) Optimizing performance of plots

12. Which of the following is the primary function to create line plots in Matplotlib?
    - a) `scatter`
    - b) `bar`
    - c) `plot`
    - d) `hist`

13. To change the color of a line in a Matplotlib plot, which parameter should you modify?
    - a) `linestyle`
    - b) `linewidth`
    - c) `color`
    - d) `marker`

14. What does the `plt.show()` function do?
    - a) Save the plot to a file
    - b) Display the plot on the screen
    - c) Clear the current plot
    - d) Close all open plots

15. What is the role of `plt.xlabel()` in Matplotlib?
    - a) Label the x-axis
    - b) Set the title of the plot
    - c) Label the y-axis
    - d) Add a legend to the plot

16. Which of the following is not a valid plot type in Matplotlib?
    - a) Line plot
    - b) Bar plot
    - c) Histogram
    - d) Sequence plot

17. The `plt.savefig()` function is used to:
    - a) Display the plot inline
    - b) Save the plot to an image file
    - c) Reset the plot canvas
    - d) Display the plot in a new window

18. How can you plot multiple lines in a single Matplotlib plot?
    - a) Use separate `plt.plot()` calls before `plt.show()`
    - b) Use `plt.multiplot()`
    - c) Use a loop with `plt.scatter()`
    - d) It is not possible to plot multiple lines

19. Which of these Matplotlib functions creates a scatter plot?
    - a) `plt.plot()`
    - b) `plt.scatter()`
    - c) `plt.bar()`
    - d) `plt.hist()`

20. What is the default file format for saving plots using `plt.savefig()`?
    - a) .png
    - b) .jpg
    - c) .pdf
    - d) .svg

### Section 3: Advanced Matplotlib Features

21. What parameter is used to set the transparency of a plot?
    - a) `color`
    - b) `alpha`
    - c) `linewidth`
    - d) `style`

22. Which function is used to add a grid to a Matplotlib plot?
    - a) `plt.add_grid()`
    - b) `plt.grid()`
    - c) `plt.show_grid()`
    - d) `plt.enable_grid()`

23. The `plt.legend()` function is used for:
    - a) Adding a title to the plot
    - b) Adding a legend to the plot
    - c) Labeling the axes
    - d) Saving the plot

24. To change the figure size of a Matplotlib plot, which function is used?
    - a) `plt.set_size()`
    - b) `plt.figure(figsize=(width, height))`
    - c) `plt.resize()`
    - d) `plt.dimensions()`

25. Which command clears all plots in Matplotlib?
    - a) `plt.show()`
    - b) `plt.clear()`
    - c) `plt.clf()`
    - d) `plt.reset()`

26. What is the purpose of the `marker` parameter in `plt.plot()`?
    - a) Change the line color
    - b) Add markers to data points
    - c) Adjust the line width
    - d) Create a scatter plot

27. To create subplots in a Matplotlib figure, which function is used?
    - a) `plt.grid()`
    - b) `plt.subplots()`
    - c) `plt.multiplot()`
    - d) `plt.figure()`

28. Which parameter is used to set the thickness of a line in Matplotlib?
    - a) `linewidth`
    - b) `linestyle`
    - c) `marker`
    - d) `color`

29. To display a color bar alongside a plot, which function is used?
    - a) `plt.colorbar()`
    - b) `plt.bar()`
    - c) `plt.legend()`
    - d) `plt.show()`

30. What is the purpose of `plt.tight_layout()`?
    - a) Clear the current figure
    - b) Adjust spacing between subplots
    - c) Set a tight margin around the plot
    - d) Enable grid lines

### Section 4: Mixed Questions

31. Which library is typically used alongside Matplotlib for numerical computations?
    - a) SciPy
    - b) NumPy
    - c) Pandas
    - d) Seaborn

32. A common file format for saving plots in vector format is:
    - a) .jpg
    - b) .png
    - c) .svg
    - d) .bmp

33. In a scatter plot, the size of the markers can be set using which parameter?
    - a) `size`
    - b) `s`
    - c) `marker`
    - d) `scale`

34. The term "interactive mode" in Matplotlib refers to:
    - a) Real-time updates to plots
    - b) Saving plots as interactive HTML files
    - c) Displaying plots only in Jupyter Notebooks
    - d) Optimized rendering of large datasets

35. What does the abbreviation SAM stand for in bioinformatics?
    - a) Sequencing Alignment Model
    - b) Sequence Analysis Module
    - c) Sequence Alignment/Map
    - d) Sequencing Annotation Model

36. In the context of GFF files, what does the "feature" column represent?
    - a) A description of the genomic region
    - b) The start and end positions of a feature
    - c) The type of genomic element (e.g., exon, gene)
    - d) The sequence ID

37. A typical FASTA file consists of:
    - a) Header and sequence data
    - b) Sequence and quality scores
    - c) Annotations and metadata
    - d) Raw sequence reads

38. To create a histogram in Matplotlib, which function is used?
    - a) `plt.bar()`
    - b) `plt.hist()`
    - c) `plt.scatter()`
    - d) `plt.plot()`

39. The command `plt.xlim()` is used to:
    - a) Set the limits for the x-axis
    - b) Label the x-axis
    - c) Add ticks to the x-axis
    - d) Clear the x-axis

40. Which function is used to overlay multiple plots on a single axis?
    - a) `plt.overlay()`
    - b) `plt.merge()`
    - c) Multiple calls to `plt.plot()`
    - d) `plt.combine()`

