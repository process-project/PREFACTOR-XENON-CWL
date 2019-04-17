#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool

baseCommand: singularity
arguments: ["exec", "-B", "/var/scratch/madougou/LOFAR/", "/var/scratch/madougou/LOFAR/lofar.simg", "wsclean", "-v", "-log-time", "-size", "4200", "4480", "-maxuv-l", "7000", "-baseline-averaging", "6.72164158179", "-local-rms-method", "rms-with-min", "-mgain", "0.8", "-auto-mask", "3.3", "-pol", "I", "-padding", "1.4", "-weighting-rank-filter", "3", "-auto-threshold", "0.5", "-j", "8", "-local-rms-window", "50", "-mem", "20", "-weight", "briggs", "0.0", "-name", "/var/scratch/madougou/LOFAR/prefactor_output/P23-wsclean", "-scale", "0.00208", "-threshold", "0.0", "-niter", "50000", "-no-update-model-required", "-reorder", "-local-rms", "-fit-beam", "/var/scratch/madougou/LOFAR/prefactor_output/Pre-Facet-Target-L232875/results/L232875_SB000_uv.dppp_124B2FCD4t_121MHz.pre-cal.ms", "/var/scratch/madougou/LOFAR/prefactor_output/Pre-Facet-Target-L232875/results/L232875_SB000_uv.dppp_124B2FCD4t_123MHz.pre-cal.ms"]


stdout: out3.txt

inputs:
  out_parse2:
    type: string

outputs:
  out_file3:
    type: stdout
