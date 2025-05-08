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
            break # Keluar dari perulangan jika input valid
        else
            echo "Silakan coba lagi."
        fi
    done
}

# Fungsi untuk menambahkan expense (pengeluaran)
add_expense() {
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
            break # Keluar dari perulangan jika input valid
        else
            echo "Silakan coba lagi."
        fi
    done
}

# Fungsi untuk menampilkan laporan pendapatan dan pengeluaran
show_report() {
    # Variabel untuk menyimpan total pendapatan, pengeluaran, dan saldo bersih
    total_income=0
    total_expense=0
    net_balance=0

    # Menampilkan header laporan
    echo "Laporan Pendapatan dan Pengeluaran:"
    echo "-----------------------------------"

    # Menampilkan semua pendapatan yang ada dan menghitung total pendapatan
    for ((i = 0; i < ${#income[@]}; i++)); do
        echo "Pendapatan: ${income[$i]} - Deskripsi: ${income_desc[$i]}"
        total_income=$((total_income + income[$i])) # Menjumlahkan total pendapatan
    done

    # Menampilkan semua pengeluaran yang ada dan menghitung total pengeluaran
    for ((i = 0; i < ${#expense[@]}; i++)); do
        echo "Pengeluaran: ${expense[$i]} - Deskripsi: ${expense_desc[$i]}"
        total_expense=$((total_expense + expense[$i])) # Menjumlahkan total pengeluaran
    done

    # Menghitung saldo bersih (net balance) = total pendapatan - total pengeluaran
    net_balance=$((total_income - total_expense))

    # Menampilkan hasil perhitungan saldo
    echo "-----------------------------------"
    echo "Total Pendapatan: $total_income"
    echo "Total Pengeluaran: $total_expense"
    echo "Saldo Bersih: $net_balance"

    # Penanganan jika saldo bersih negatif
    if ((net_balance < 0)); then
        echo "Peringatan: Saldo bersih Anda NEGATIF!"
    fi
}

# Fungsi utama untuk menampilkan menu dan mengatur alur aplikasi
main() {
    # Perulangan untuk menampilkan menu utama terus menerus
    while true; do
        # Menampilkan menu pilihan kepada pengguna
        echo "Selamat datang di Income & Expense Manager!"
        echo "1. Tambah Pendapatan"
        echo "2. Tambah Pengeluaran"
        echo "3. Tampilkan Laporan"
        echo "4. Keluar"
        echo -n "Pilih menu (1/2/3/4): "
        read choice # Membaca pilihan menu dari pengguna

        # Percabangan menggunakan 'case' untuk menangani pilihan menu pengguna
        case $choice in
        1)
            add_income # Panggil fungsi untuk menambahkan pendapatan
            ;;
        2)
            add_expense # Panggil fungsi untuk menambahkan pengeluaran
            ;;
        3)
            show_report # Panggil fungsi untuk menampilkan laporan
            ;;
        4)
            echo "Terima kasih telah menggunakan aplikasi ini." # Menampilkan pesan keluar
            exit 0                                              # Keluar dari program
            ;;
        *)
            echo "Pilihan tidak valid. Silakan coba lagi." # Menangani input yang tidak valid
            ;;
        esac
        echo "" # Baris kosong untuk pemisah
    done
}

# Memanggil fungsi utama untuk memulai aplikasi
main
