
## ✅ Validation & Benchmarking
To ensure 100% algorithmic reliability, this solver was benchmarked against analytical solutions from **"Vector Mechanics for Engineers: Statics and Dynamics" (9th Edition)** by Beer, Johnston, Mazurek, Cornwell, and Eisenberg.

The code successfully solved and verified the following problems:
* **Problem 6.4:** Verified basic nodal equilibrium and internal force identification.
* **Problem 6.11:** Validated support reactions and symmetry logic.
* **Problem 6.13:** Confirmed accuracy for complex, multi-node truss systems with varied loading.

> **Note:** The solver identifies the nature of the force automatically: **Positive (+)** values indicate **Tension**, while **Negative (-)** values indicate **Compression**.







# 🏗️ Automated 2D Truss Solver (Method of Nodes)

## Project Overview
This project is a computational engine developed in **MATLAB** to automate the structural analysis of 2D trusses. Using the **Method of Nodes**, the solver derives and solves systems of equilibrium equations ($\sum F_x = 0$ and $\sum F_y = 0$) for every joint to determine internal member forces and support reactions.

It serves as a functional bridge between theoretical statics and the matrix-based logic used in modern **Finite Element Analysis (FEA)** software.


## 🚀 Key Features
* **Symbolic Solver Engine:** Utilizes the MATLAB Symbolic Math Toolbox to handle unknown forces as variables. This allows the script to generate and display the actual equilibrium equations before solving them.
* **Automated Connectivity Logic:** The script automatically identifies joint-to-member relationships, calculating directional cosines (unit vectors) for any arbitrary geometry.
* **Dual-Figure Visualization:** * **Figure 1:** Maps the truss network with indexed nodes (N) and members (M).
    * **Figure 2:** Renders external load vectors with magnitude labels for visual verification.
* **Support Versatility:** Pre-defined boundary conditions for Rollers (Ground/Wall), Hinges, Pins, and specialized Collars.

## 📊 Visual Outputs
The following figures are generated directly by the script to provide visual verification of the structural integrity and force distribution:

### 1. Truss Configuration & Numbering
Used to verify the geometric input and the connectivity of the triangular network.
![Truss Geometry](./Figure%201.png)

### 2. Force Vector Analysis
Displays the application points, directions, and magnitudes of all external loads acting on the system.
![Analysis Results](./Figure%202.png)



## ✅ Technical Validation & Benchmarking
To ensure the solver's reliability for structural engineering applications, the engine was benchmarked against manual analytical solutions from **"Vector Mechanics for Engineers: Statics and Dynamics" (9th Ed.)** by Beer & Johnston.

### Benchmark 1: Problem 6.4 (Basic Equilibrium)
* **Goal:** Verify reaction forces and internal member tension/compression.
* **Result:** Successfully identified Zero-Force members and matched manual calculations for support reactions ($R_{y4} = 4.2$, $R_{y6} = 4.2$).

### Benchmark 2: Problem 6.11 (Symmetry & Load Distribution)
* **Goal:** Test the solver's ability to handle symmetrical loading across 13 members.
* **Result:** Code accurately distributed the 2400 total load, resulting in symmetrical support reactions ($R_{y1} = 1200$, $R_{y8} = 1200$) and correct internal force magnitudes (e.g., $F_{12} = -1500$).

### Benchmark 3: Problem 6.13 (Complex Geometry)
* **Goal:** Validate the symbolic solver against non-standard angles and multiple horizontal/vertical reaction components.
* **Result:** The engine successfully derived complex equilibrium equations (e.g., using $\sqrt{41}$ and $\sqrt{61}$ coefficients) to find precise reactions ($R_{x1} = -60, R_{x5} = 60$).

---

## 🔍 The "Method of Nodes" Logic
The solver follows a rigorous engineering workflow for every joint:
1. **Isolation:** Isolates each node and identifies all connected members.
2. **Decomposition:** Calculates directional cosines ($\cos \theta, \sin \theta$) based on the nodal coordinates.
3. **Equation Generation:** Builds the system of equations: 
   $$\sum F_x = 0 \quad \text{and} \quad \sum F_y = 0$$
4. **Symbolic Resolution:** Solves the global matrix to output forces, where **(+) denotes Tension** and **(-) denotes Compression**.

## 💻 How to Use
## 🛠️ How to Set Up Your Problem

To solve a new truss structure, you only need to modify **Parts 1, 2, and 3A** of the `truss_2D_analysis_FINAL.m` script. Follow these steps:

### a. Define Geometry (PART 1)
* **Nodes:** Enter the $(x, y)$ coordinates for every joint in the `nodes` matrix. 
    * *Example:* `nodes = [0 0; 2 0;]` defines Node 1 at the origin and Node 2 at $x=2$.
* **Members:** Define which nodes are connected. 
    * *Example:* `[1 2]` creates a beam between Node 1 and Node 2.

### b. Apply External Loads (PART 2)
* Input the forces acting on each node in the `loads` matrix format: `[Horizontal Force (Rx), Vertical Force (Ry), Moment (M)]`.
* **Downward forces** must be entered as **negative** values.
* If a force is applied at an angle, calculate its $x$ and $y$ components first.

### c. Define Supports (PART 3A)
The script uses a numbering system to identify support types. Assign the corresponding number to the node in the `support_node` array:

| Value | Support Type | Restricted Movement |
| :--- | :--- | :--- |
| **0** | No Support | Free movement |
| **1** | Roller / Frictionless Surface | Vertical (y) only (On Ground) |
| **2** | Roller / Frictionless Surface | Horizontal (x) only (On Wall) |
| **5** | Hinge / Frictionless Pin | Horizontal (x) and Vertical (y) |
| **6** | Fixed Support | x, y, and Moment (M) |

> **Note:** For the best results, ensure your primary supports are located at $x=0$ to align with the solver's coordinate logic.

### d. Run the Solver
Once the values are set, simply press **Run** in MATLAB. The script will:
1.  Plot the structure for visual verification.
2.  Print all **Internal Member Forces** (Tension/Compression).
3.  Calculate all **Reaction Forces** at the supports.
---
**Author:** Thanasis Charalambous  
**Role:** Mechanical Engineer  
**Tools:** MATLAB, Statics, Structural Mechanics
