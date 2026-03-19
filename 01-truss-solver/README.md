# 🏗️ Automated 2D Truss Solver (Method of Nodes)

## Project Overview
This project is a computational engine developed in **MATLAB** to automate the structural analysis of 2D trusses. Using the **Method of Nodes**, the solver derives and solves systems of equilibrium equations ($\sum F_x = 0$ and $\sum F_y = 0$) for every joint to determine internal member forces and support reactions.

It serves as a functional bridge between theoretical statics and the matrix-based logic used in modern **Finite Element Analysis (FEA)** software.

## 🚀 Key Features
* **Symbolic Solver Engine:** Utilizes the MATLAB Symbolic Math Toolbox to handle unknown forces as variables, allowing for exact analytical solutions.
* **Automated Plotting:** Generates high-fidelity visuals to verify input and results:
    * **Geometry & Loading:** Visualizes the truss layout, node numbering, and applied external force vectors.
    * **Force Analysis:** Displays the solved internal forces, automatically distinguishing between **Tension (+)** and **Compression (-)**.
* **Support Versatility:** Logic built to handle various boundary conditions, including Hinges, Rollers, and specialized collars on frictionless rods.

## 📊 Visual Outputs
The following figures are generated directly by the script to provide visual verification of the structural integrity and force distribution:

### 1. Truss Configuration & External Loads
This figure allows for immediate verification of the input coordinates, member connectivity, and the direction/magnitude of applied loads.
![Truss Geometry](./Figure%201.png)

### 2. Solved Force Distribution
The final analysis results showing the magnitude and nature (T/C) of the force for every member in the assembly.
![Analysis Results](./Figure%202.png)

## ✅ Validation & Benchmarking
To ensure algorithmic reliability, this solver was benchmarked against analytical solutions from **"Vector Mechanics for Engineers: Statics"** (Beer & Johnston):
* **Problem 6.13:** Verified complex internal force distribution in a multi-node truss.
* **Problem 6.16:** Validated support reactions and nodal equilibrium under combined loading.
* **Technical Documentation:** Detailed manual calculations and theory are available in the included [Technical Report](./STATICS%20-%20TRUSS%20STRUCTURE.pdf).

## 💻 How to Use
1.  **Environment:** Open `truss_2D_analysis_FINAL.m` in MATLAB.
2.  **Define Geometry:** Input node coordinates in the `nodes` matrix and connectivity in the `members` matrix (**PART 1**).
3.  **Apply Loads:** Define external forces and support types at specific nodes in **PART 3A**.
4.  **Execute:** Run the script to generate visual plots and a full force report in the MATLAB Command Window.

---
**Author:** Thanasis Charalambous  
**Role:** Mechanical Engineer  
**Tools:** MATLAB, Statics, Structural Mechanics
