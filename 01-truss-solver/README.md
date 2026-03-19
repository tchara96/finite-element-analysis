# Automated 2D Truss Solver (Method of Nodes)

## Project Overview
This module is a computational engine built in MATLAB to automate the structural analysis of 2D trusses. It replaces manual "Method of Nodes" calculations with a symbolic solver capable of handling N-node structures.

## Technical Implementation
* **Solver Engine:** Uses `syms` to generate and solve equilibrium equations for every joint.
* **Geometry:** Defined via a coordinate matrix and connectivity array.
* **Support Types:** Includes logic for Hinges, Rollers, and Collars.

## Visual Output
![Truss Plot](./truss-plot.png)

## Validation
The results produced by this code were verified against Problem 6.13 and 6.16 from *Vector Mechanics for Engineers: Statics*.
