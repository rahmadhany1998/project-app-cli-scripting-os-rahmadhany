#!/bin/bash

#Mendeklarasikan ANSI escape colors untuk output pada bash
RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
BLUE="\e[34m"
WHITE="\e[97m"
ENDCOLOR="\e[0m"

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
        echo -e "${GREEN}Masukkan jumlah pendapatan: ${ENDCOLOR}"
        read amount

        # Validasi input untuk memastikan hanya angka
        if validate_number "$amount"; then
            income+=($amount) # Menambahkan pendapatan ke dalam array income

            # Minta pengguna untuk memasukkan deskripsi pendapatan
            echo -e "${GREEN}Masukkan deskripsi pendapatan: ${ENDCOLOR}"
            read desc
            income_desc+=($desc) # Menambahkan deskripsi pendapatan ke dalam array descriptions

            echo -e "${GREEN}Pendapatan berhasil ditambahkan.${ENDCOLOR}"
            break # Keluar dari perulangan jika input valid
        else
            echo -e "${RED}Silakan coba lagi.${ENDCOLOR}"
        fi
    done
}

# Fungsi untuk menambahkan expense (pengeluaran)
add_expense() {
    while true; do
        # Minta pengguna untuk memasukkan jumlah pengeluaran
        echo -e "${RED}Masukkan jumlah pengeluaran: ${ENDCOLOR}"
        read amount

        # Validasi input untuk memastikan hanya angka
        if validate_number "$amount"; then
            expense+=($amount) # Menambahkan pengeluaran ke dalam array expense

            # Minta pengguna untuk memasukkan deskripsi pengeluaran
            echo -e "${RED}Masukkan deskripsi pengeluaran: ${ENDCOLOR}"
            read desc
            expense_desc+=($desc) # Menambahkan deskripsi pengeluaran ke dalam array descriptions

            echo -e "${GREEN}Pengeluaran berhasil ditambahkan.${ENDCOLOR}"
            break # Keluar dari perulangan jika input valid
        else
            echo -e "${RED}Silakan coba lagi.${ENDCOLOR}"
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
    echo -e "${BLUE}Laporan Pendapatan dan Pengeluaran:${ENDCOLOR}"
    echo "-----------------------------------"

    # Menampilkan semua pendapatan yang ada dan menghitung total pendapatan
    for ((i = 0; i < ${#income[@]}; i++)); do
        echo -e "${GREEN}Pendapatan: ${income[$i]} - Deskripsi: ${income_desc[$i]}${ENDCOLOR}"
        total_income=$((total_income + income[$i])) # Menjumlahkan total pendapatan
    done

    # Menampilkan semua pengeluaran yang ada dan menghitung total pengeluaran
    for ((i = 0; i < ${#expense[@]}; i++)); do
        echo -e "${RED}Pengeluaran: ${expense[$i]} - Deskripsi: ${expense_desc[$i]}${ENDCOLOR}"
        total_expense=$((total_expense + expense[$i])) # Menjumlahkan total pengeluaran
    done

    # Menghitung saldo bersih (net balance) = total pendapatan - total pengeluaran
    net_balance=$((total_income - total_expense))

    # Menampilkan hasil perhitungan saldo
    echo "-----------------------------------"
    echo -e "${GREEN}Total Pendapatan: $total_income${ENDCOLOR}"
    echo -e "${RED}Total Pengeluaran: $total_expense${ENDCOLOR}"
    echo -e "${BLUE}Saldo Bersih: $net_balance${ENDCOLOR}"

    # Penanganan jika saldo bersih negatif
    if ((net_balance < 0)); then
        echo -e "${RED}Peringatan: Saldo bersih Anda NEGATIF!${ENDCOLOR}"
    fi
}

# Fungsi utama untuk menampilkan menu dan mengatur alur aplikasi
main() {
    # Perulangan untuk menampilkan menu utama terus menerus
    while true; do
        # Menampilkan menu pilihan kepada pengguna
        echo -e "${YELLOW}Selamat datang di Income & Expense Manager!${ENDCOLOR}"
        echo -e "${GREEN}1. Tambah Pendapatan${ENDCOLOR}"
        echo -e "${RED}2. Tambah Pengeluaran${ENDCOLOR}"
        echo -e "${BLUE}3. Tampilkan Laporan${ENDCOLOR}"
        echo -e "${WHITE}4. Keluar${ENDCOLOR}"
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
            echo -e "${GREEN}Terima kasih telah menggunakan aplikasi ini.${ENDCOLOR}" # Menampilkan pesan keluar
            exit 0                                                                    # Keluar dari program
            ;;
        *)
            echo -e "${RED}Pilihan tidak valid. Silakan coba lagi.${ENDCOLOR}" # Menangani input yang tidak valid
            ;;
        esac
        echo "" # Baris kosong untuk pemisah
    done
}

# Memanggil fungsi utama untuk memulai aplikasi
main
