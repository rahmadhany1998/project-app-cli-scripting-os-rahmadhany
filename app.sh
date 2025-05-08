#!/bin/bash

# Mendeklarasikan array untuk menyimpan data pendapatan (income), pengeluaran (expense), dan deskripsi (descriptions)
declare -a income
declare -a expense
declare -a descriptions

# Fungsi untuk menambahkan income (pendapatan)
add_income() {
    total_income=0
    # Minta pengguna untuk memasukkan jumlah pendapatan
    echo "Masukkan jumlah pendapatan: "
    read amount
    income+=($amount) # Menambahkan pendapatan ke dalam array income
    # Minta pengguna untuk memasukkan deskripsi pendapatan
    echo "Masukkan deskripsi pendapatan: "
    read desc
    descriptions+=($desc) # Menambahkan deskripsi pendapatan ke dalam array descriptions
    echo "Pendapatan berhasil ditambahkan."
    # Menampilkan semua pendapatan yang ada dan menghitung total pendapatan
    for ((i = 0; i < ${#income[@]}; i++)); do
        echo "Pendapatan: ${income[$i]} - Deskripsi: ${descriptions[$i]}"
        total_income=$((total_income + income[$i])) # Menjumlahkan total pendapatan
    done
}

while true; do
    add_income
done
