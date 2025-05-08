#!/bin/bash

# Mendeklarasikan array untuk menyimpan data pendapatan (income), pengeluaran (expense), deskripsi pendapatan (income_desc) dan deskripsi pengeluaran (expense_desc)
declare -a income
declare -a expense
declare -a income_desc
declare -a expense_desc

# Fungsi untuk memvalidasi input apakah itu angka
validate_number() {
    # Menggunakan regex untuk memeriksa apakah input hanya angka
    if [[ ! $1 =~ ^[0-9]+$ ]]; then
        echo "Input tidak valid. Harus berupa angka."
        return 1 # Jika input bukan angka, mengembalikan nilai 1 (gagal)
    fi
    return 0 # Jika input valid, mengembalikan nilai 0 (berhasil)
}

# Fungsi untuk menambahkan income (pendapatan)
add_income() {
    total_income=0
    while true; do
        # Minta pengguna untuk memasukkan jumlah pendapatan
        echo "Masukkan jumlah pendapatan: "
        read amount

        # Validasi input untuk memastikan hanya angka
        if validate_number "$amount"; then
            income+=($amount) # Menambahkan pendapatan ke dalam array income

            # Minta pengguna untuk memasukkan deskripsi pendapatan
            echo "Masukkan deskripsi pendapatan: "
            read desc
            income_desc+=($desc) # Menambahkan deskripsi pendapatan ke dalam array descriptions

            echo "Pendapatan berhasil ditambahkan."

            #Menampilkan semua pendapatan yang ada dan menghitung total pendapatan
            for ((i = 0; i < ${#income[@]}; i++)); do
                echo "Pendapatan: ${income[$i]} - Deskripsi: ${income_desc[$i]}"
                total_income=$((total_income + income[$i])) # Menjumlahkan total pendapatan
            done

            # Menampilkan hasil pendapatan
            echo "Total Pendapatan: $total_income"
            break # Keluar dari perulangan jika input valid
        else
            echo "Silakan coba lagi."
        fi
    done
}

# Fungsi untuk menambahkan expense (pengeluaran)
add_expense() {
    total_expense=0
    while true; do
        # Minta pengguna untuk memasukkan jumlah pengeluaran
        echo "Masukkan jumlah pengeluaran: "
        read amount

        # Validasi input untuk memastikan hanya angka
        if validate_number "$amount"; then
            expense+=($amount) # Menambahkan pengeluaran ke dalam array expense

            # Minta pengguna untuk memasukkan deskripsi pengeluaran
            echo "Masukkan deskripsi pengeluaran: "
            read desc
            expense_desc+=($desc) # Menambahkan deskripsi pengeluaran ke dalam array descriptions

            echo "Pengeluaran berhasil ditambahkan."

            # Menampilkan semua pengeluaran yang ada dan menghitung total pengeluaran
            for ((i = 0; i < ${#expense[@]}; i++)); do
                echo "Pengeluaran: ${expense[$i]} - Deskripsi: ${expense_desc[$i]}"
                total_expense=$((total_expense + expense[$i])) # Menjumlahkan total pengeluaran
            done

            # Menampilkan hasil pengeluaran
            echo "Total Pengeluaran: $total_expense"
            break # Keluar dari perulangan jika input valid
        else
            echo "Silakan coba lagi."
        fi
    done
}

while true; do
    add_income
    add_expense
done
