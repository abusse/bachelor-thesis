$ENV{'TEXINPUTS'}='./lib/:' . $ENV{'TEXINPUTS'};

$clean_ext = "run.xml pdfa.xmpi mw lol";
$clean_full_ext = "run.xml pdfa.xmpi mw lol";

$pdf_mode = 1; # tex -> pdf

@default_files = ('thesis-main.tex');

# When the source file uses bbl files for bibliography, run bibtex or biber as needed to regenerate the bbl files.
$bibtex_use = 2;

$pdflatex = 'pdflatex -shell-escape %O %S';

add_cus_dep('glo', 'gls', 0, 'run_makeindex');
add_cus_dep('acn', 'acr', 0, 'run_makeindex');
sub run_makeindex {
   my $source = $$Psource;
   my $dest = $$Pdest;
   my $log = $dest."LOG";
   my $cmd = "makeindex %O -s \"$_[0].ist\"  -t \"$log\" -o \"$dest\" \"$source\"";
   if ($silent) { $cmd =~ s/%O/-q/; }
   else { $cmd =~ s/%O//; }
   return system $cmd;
}