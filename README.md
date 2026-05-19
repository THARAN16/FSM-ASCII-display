# Verilog Character Sequence Generator

A Verilog module that generates a continuous, sequential output of ASCII characters forming the word **"EXAMPLE"**. This project demonstrates basic hardware design concepts, including counter logic, Finite State Machine (FSM) design, and using a `case` statement to simulate a small Read-Only Memory (ROM).

## 🚀 Overview

The `name_generator` module outputs an 8-bit ASCII character on every positive edge of the clock. It utilizes a internal counter that acts as the state register for a simple **Moore-type Finite State Machine (FSM)**. The current state (the counter value) strictly determines the output character. Once the full sequence is completed, the FSM loops back to the initial state, repeating the word indefinitely.

## 🛠️ Module Interface

| Port Name | Direction | Width | Description |
| :--- | :--- | :--- | :--- |
| `clk` | Input | 1-bit | System clock signal. |
| `rst` | Input | 1-bit | Asynchronous active-high reset. Clears the counter and output. |
| `char_out` | Output | 8-bit | The current ASCII character output. |

## ⚙️ How It Works (FSM Architecture)

This module is essentially a sequential circuit operating as an FSM:

1. **State Register (The Counter):** A 3-bit register (`counter`) holds the current state of the machine (from `0` to `6`).
2. **Next-State Logic:** On every positive clock edge, the state increments by 1. When the state reaches `6` (the final letter), the next-state logic forces it to wrap around back to `0`.
3. **Output Logic (ROM Lookup):** A combinational `case` statement acts as a small ROM. It maps the current state directly to an 8-bit ASCII value:
    * State `0` → "E"
    * State `1` → "X"
    * State `2` → "A"
    * State `3` → "M"
    * State `4` → "P"
    * State `5` → "L"
    * State `6` → "E"
4. **Reset Condition:** Driving `rst` HIGH forces the state to `0` and outputs a Null character (`8'd0`).

## 💻 Simulation & Viewing the Output

To simulate this module, you must provide a clock and a brief reset signal using a testbench. 

> **⚠️ IMPORTANT TIP FOR WAVEFORM VIEWERS:** 
> By default, simulation tools (like Vivado, ModelSim, or GTKWave) will display the `char_out` signal in Binary or Hexadecimal format. To read the text properly, right-click the `char_out` signal in your waveform window, navigate to **Radix**, and change it to **ASCII**. 

## 🔧 How to Customize the Sequence & Length

If you want to change the output word to a different name or sequence, you will need to adjust a few elements in the Verilog code:

1. **Update the Letters:** Change the characters assigned within the `case(counter)` statement to match your new word.
2. **Adjust the Wrap-Around Condition:** Find the `if (counter == 3'd6)` line. Change the `6` to the index of your new word's last letter (Length of word - 1).
3. **Increase Counter Width (If necessary):** The current 3-bit counter (`reg [2:0] counter`) can only hold values from 0 to 7 (an 8-letter word max). If your new word is longer than 8 letters, you must increase the bit-width of the counter:
    * Up to 16 letters: `reg [3:0] counter;`
    * Up to 32 letters: `reg [4:0] counter;`
