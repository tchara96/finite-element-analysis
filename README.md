# 🏗️ Finite Element Analysis & Structural Mechanics

Welcome to my FEA portfolio. This repository serves as a centralized hub for computational engineering projects, focusing on structural analysis, matrix methods, and automated solvers for mechanical systems.

## 📁 Project Directory

### 1. Automated 2D Truss Solver (Method of Nodes)
**Tools:** MATLAB, Symbolic Math Toolbox, Structural Statics
* **Description:** A robust computational engine developed to automate the **Method of Nodes**. It solves for internal member forces (Tension/Compression) and support reactions for any user-defined N-node truss.
* **Core Logic:** * Translates Free Body Diagram (FBD) physics into systems of equilibrium equations ($\sum F_x = 0$, $\sum F_y = 0$).
    * Uses symbolic variables to handle complex joints and unknown reactions.
* **Key Features:**
    * Supports various constraints: Hinges, Rollers, and specialized collars.
    * Automated plotting of truss geometry, node numbering, and load vectors.
    * Validated against analytical solutions from *Vector Mechanics for Engineers*.
* [**📂 View Project Files**](./01-truss-solver/)

---

## 🛠️ Technical Skills Demonstrated
* **Computational Modeling:** Translating physical laws into matrix-based numerical solvers.
* **Structural Analysis:** Deep understanding of nodal equilibrium, truss optimization, and vector mechanics.
* **Software Proficiency:** MATLAB (Symbolic Math, Data Visualization), Autodesk Fusion (CAD/CAE).
* **Verification & Validation (V&V):** Implementing rigorous benchmarking to ensure algorithmic accuracy against manual calculations.

---

## 🚀 Future Roadmap
As I expand this portfolio, I will be adding:
- [ ] **Beam Element Solver:** Incorporating bending moments and shear stress analysis.
- [ ] **2D Frame Analysis:** Implementing the Global Stiffness Matrix method for rigid frames.
- [ ] **Thermal FEA:** Simulating steady-state heat conduction in 2D plates.

---

## 📄 License
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---
**Contact:** [Thanasis Charalambous] – [www.linkedin.com/in/thanasis-charalambous-459a4629b]
