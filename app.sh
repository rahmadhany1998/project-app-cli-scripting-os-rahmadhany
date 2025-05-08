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
    # Menampilkan hasil pendapatan
    echo "Total Pendapatan: $total_income"
}

# Fungsi untuk menambahkan expense (pengeluaran)
add_expense() {
    total_expense=0
    # Minta pengguna untuk memasukkan jumlah pengeluaran
    echo "Masukkan jumlah pengeluaran: "
    read amount
    expense+=($amount) # Menambahkan pengeluaran ke dalam array expense
    # Minta pengguna untuk memasukkan deskripsi pengeluaran
    echo "Masukkan deskripsi pengeluaran: "
    read desc
    descriptions+=($desc) # Menambahkan deskripsi pengeluaran ke dalam array descriptions
    echo "Pengeluaran berhasil ditambahkan."
    # Menampilkan semua pengeluaran yang ada dan menghitung total pengeluaran
    for ((i = 0; i < ${#expense[@]}; i++)); do
        echo "Pengeluaran: ${expense[$i]} - Deskripsi: ${descriptions[$i + ${#income[@]}]}"
        total_expense=$((total_expense + expense[$i])) # Menjumlahkan total pengeluaran
    done
    # Menampilkan hasil pengeluaran
    echo "Total Pengeluaran: $total_expense"
}

while true; do
    add_income
    add_expense
done
