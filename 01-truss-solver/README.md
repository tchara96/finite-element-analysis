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
## 🛠️ How to Set Up Your Problem

To solve a new truss structure, you only need to modify **Parts 1, 2, and 3A** of the `truss_2D_analysis_FINAL.m` script. Follow these steps:

### 1. Define Geometry (PART 1)
* **Nodes:** Enter the $(x, y)$ coordinates for every joint in the `nodes` matrix. 
    * *Example:* `nodes = [0 0; 2 0;]` defines Node 1 at the origin and Node 2 at $x=2$.
* **Members:** Define which nodes are connected. 
    * *Example:* `[1 2]` creates a beam between Node 1 and Node 2.

### 2. Apply External Loads (PART 2)
* Input the forces acting on each node in the `loads` matrix format: `[Horizontal Force (Rx), Vertical Force (Ry), Moment (M)]`.
* **Downward forces** must be entered as **negative** values.
* If a force is applied at an angle, calculate its $x$ and $y$ components first.

### 3. Define Supports (PART 3A)
The script uses a numbering system to identify support types. Assign the corresponding number to the node in the `support_node` array:

| Value | Support Type | Restricted Movement |
| :--- | :--- | :--- |
| **0** | No Support | Free movement |
| **1** | Roller / Frictionless Surface | Vertical (y) only (On Ground) |
| **2** | Roller / Frictionless Surface | Horizontal (x) only (On Wall) |
| **5** | Hinge / Frictionless Pin | Horizontal (x) and Vertical (y) |
| **6** | Fixed Support | x, y, and Moment (M) |

> **Note:** For the best results, ensure your primary supports are located at $x=0$ to align with the solver's coordinate logic.

### 4. Run the Solver
Once the values are set, simply press **Run** in MATLAB. The script will:
1.  Plot the structure for visual verification.
2.  Print all **Internal Member Forces** (Tension/Compression).
3.  Calculate all **Reaction Forces** at the supports.
---
**Author:** Thanasis Charalambous  
**Role:** Mechanical Engineer  
**Tools:** MATLAB, Statics, Structural Mechanics
