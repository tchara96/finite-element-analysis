# 🏗️ Automated 2D Truss Solver (Method of Nodes)

## Project Overview
This project is a computational engine developed in **MATLAB** to automate the structural analysis of 2D trusses. Using the **Method of Nodes**, the solver derives and solves systems of equilibrium equations ($\sum F_x = 0$ and $\sum F_y = 0$) for every joint to determine internal member forces and support reactions.

It serves as a functional bridge between theoretical statics and the matrix-based logic used in modern **Finite Element Analysis (FEA)** software.

## 🚀 Key Features
* **Symbolic Solver Engine:** Utilizes the MATLAB Symbolic Math Toolbox to handle unknown forces as variables. This allows the script to generate and display the actual equilibrium equations before solving them.
* **Automated Connectivity Logic:** Automatically identifies joint-to-member relationships, calculating directional cosines (unit vectors) for any arbitrary geometry.
* **Support Versatility:** Pre-defined boundary conditions for Rollers (Ground/Wall), Hinges, Pins, and specialized Collars.
* **Visual Verification:** Dual-figure output for geometric mapping and load-vector distribution.

## 📊 Visual & Technical Outputs
When the solver is executed, it generates a comprehensive technical package:

### 1. Graphical Visualizations
* **Truss Network Map (Figure 1):** A geometric plot displaying the assembly of the truss with indexed nodes (N) and members (M).
![Truss Geometry](./Figure%201.png)
* **Force Vector Plot (Figure 2):** A load-distribution map rendering external forces as scaled red vectors for immediate verification.
![Analysis Results](./Figure%202.png)

### 2. Data Reports (Command Window)
* **Symbolic Equilibrium Report:** Lists the unique equilibrium equations generated for every joint (e.g., `Equation 10: F2 + (5*F10)/13 + Ry5 == 0`).
* **Solved Member Forces Table:** A categorized list of internal forces where **Positive (+)** denotes Tension and **Negative (-)** denotes Compression.
* **Support Reaction Matrix:** A final $[N \times 3]$ matrix showing $(R_x, R_y, M)$ values for every node.

---

## 🛠️ How to Set Up Your Problem
To solve a new truss structure, modify **Parts 1, 2, and 3A** of the `truss_2D_analysis_FINAL.m` script:

### a. Define Geometry (PART 1)
* **Nodes:** Enter $(x, y)$ coordinates. *Example:* `nodes = [0 0; 2 0;]` 
* **Members:** Define node connections. *Example:* `[1 2]` connects Node 1 and Node 2.

### b. Apply External Loads (PART 2)
* Input forces in the `loads` matrix: `[Horizontal Force (Rx), Vertical Force (Ry), Moment (M)]`.
* **Note:** Downward forces must be **negative**.

### c. Define Supports (PART 3A)
Assign the corresponding support number to the node in the `support_node` array:

| Value | Support Type | Restricted Movement |
| :--- | :--- | :--- |
| **0** | No Support | Free movement |
| **1** | Roller (Ground) | Vertical (y) only |
| **2** | Roller (Wall) | Horizontal (x) only |
| **5** | Hinge / Pin | Horizontal (x) and Vertical (y) |
| **6** | Fixed Support | x, y, and Moment (M) |

---

## ✅ Technical Validation & Benchmarking
The engine was benchmarked against analytical solutions from **"Vector Mechanics for Engineers: Statics and Dynamics" (9th Ed.)** by Beer & Johnston to ensure 100% reliability.

* **Benchmark 1 (Problem 6.4):** Successfully identified Zero-Force members and matched support reactions ($R_{y4} = 4.2, R_{y6} = 4.2$).
* **Benchmark 2 (Problem 6.11):** Accurately handled symmetrical loading across 13 members ($R_{y1} = 1200, R_{y8} = 1200$).
* **Benchmark 3 (Problem 6.13):** Validated against complex geometry using exact symbolic coefficients (e.g., $\sqrt{41}$ and $\sqrt{61}$ fractions).

## 🔍 The "Method of Nodes" Logic
The solver follows a rigorous engineering workflow for every joint:
1. **Isolation:** Isolates each node and identifies all connected members.
2. **Decomposition:** Calculates directional cosines ($\cos \theta, \sin \theta$) based on the nodal coordinates.
3. **Equation Generation:** Builds the system of equations: 
   $$\sum F_x = 0 \quad \text{and} \quad \sum F_y = 0$$
4. **Symbolic Resolution:** Solves the global matrix to output forces, where **(+) denotes Tension** and **(-) denotes Compression**.

---
**Author:** Thanasis Charalambous  
**Role:** Mechanical Engineer  
**Tools:** MATLAB, Symbolic Math Toolbox, Structural Mechanics
