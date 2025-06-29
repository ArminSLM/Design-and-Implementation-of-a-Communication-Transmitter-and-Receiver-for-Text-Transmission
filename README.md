# Design-and-Implementation-of-a-Communication-Transmitter-and-Receiver-for-Text-Transmission
Channel Modeling and Noise Characterization | Filter Design and Signal Frequency Analysis | Modulation Scheme Implementation and Optimization | Channel Capacity Estimation and Error Rate Analysis | Message Transmission, Reconstruction, and Validation
<p align="center">
  <img src="https://github.com/user-attachments/assets/e99bffe6-1c6d-4f6a-a5e2-ed1711d826b8" width="600"/>
  <br/>
  <b>Full Architecture</b>
</p>
## 📂 Project Structure

- `channel_design.fda`: Filter design file for channel specification.
- `Simulink_Model.slx`: Complete Simulink model including modulation, channel, and demodulation.
- `huffman_coding.m`: MATLAB script to compute Huffman coding.
- `bpsk_blocks/`: Contains BPSK modulation and demodulation logic.
- `project_report.pdf`: Detailed written report with figures and parameter analysis.
## 🎯 Objectives

- Design a **low-pass equiripple channel filter** with 100 kHz sampling rate.
- Evaluate step response and group delay using filterDesigner tool.
- Add **Gaussian noise** to the channel (N₀ = 0.002) and compute discrete variance.
- Encode a `.txt` message using **Huffman coding** and compare it to **Lempel-Ziv**.
- Transmit data in less than **15 seconds**.
- Modulate the coded signal using **BPSK** with Gaussian pulse shaping.
- Implement full transmitter–channel–receiver system in Simulink.
- Evaluate **bit error rate (BER)** and channel performance under noise.
## 🧪 Methodology

### 🔁 Source Coding
- Huffman coding used to compress `.txt` messages.
- Compared entropy and average codeword length.
- Achieved efficiency ~0.995.

### 📡 Modulation
- BPSK chosen for its simplicity and noise resilience.
- Gaussian pulses as basis functions.
- Calculated symbol energy E = 0.005 for Tx power P = 5.

### 📶 Channel Modeling
- FIR low-pass filter designed using FDA tool.
- Channel includes **group delay ≈ 102** samples.
- Gaussian noise added via `Random Source` in Simulink.

### 🔄 Demodulation
- Implemented matched filter and decision logic.
- Applied time shift to align symbol window.
- Decoded signal back to binary and evaluated BER.

### 📈 Evaluation
- Compared original vs received bits.
- Calculated BER using `Q(sqrt(2E/N₀))`.
- Verified transmission within 14.2 seconds.
## 📷 Sample Figures



<p align="center">
  <img src="https://github.com/user-attachments/assets/edc95b20-4958-424d-af38-398bbcb4fa21" width="500"/>
  <br/>
  <b>BPSK Demodulator</b>
</p>

<p align="center">
  <img src="https://github.com/user-attachments/assets/e27df7fb-b3be-474b-9b5f-6df3691282e5" width="500"/>
  <br/>
  <b>BPSK Modulator</b>
</p>

<p align="center">
  <img src="https://github.com/user-attachments/assets/142213c5-fa86-4de2-9848-0872e99679ee" width="500"/>
  <br/>
  <b>OOK Modulator</b>
</p>



