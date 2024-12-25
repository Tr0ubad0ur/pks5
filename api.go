package main

import (
	"encoding/json"
	"fmt"
	"net/http"
	"strconv"
)


type Product struct {
	ID          int
	Title       string
	ImageURL    string
	Name        string
	Price       int
	Description string
	Specifications string
	Quantity    int
	IsFavorite     bool
    InCart         bool
}

var products = []Product{
	{
		ID:          1,
		Title:       "Электрогитара FENDER",
		ImageURL:    "https://www.muztorg.ru/files/egx/po4/bqz/808/k0c/48w/so0/8w4/w/egxpo4bqz808k0c48wso08w4w.jpeg",
		Name:        "Электрогитара FENDER",
		Price:       47000,
		Description: "Электрогитара FENDER SQUIER Affinity 2021 Telecaster MN Butterscotch Blonde",
		Specifications: "Количество ладов (диапазон): 21\nКоличество струн: 6\nКонфигурация звукоснимателей: S-s\nКрепление грифа: на болтах\nМатериал грифа: клён\nМатериал корпуса: тополь\nОриентация: правосторонняя\nФорма корпуса: Telecaster\nМензура, дюймы: 25.5\nТип электроники: пассивная",
		Quantity:    0,
	},
	{
		ID:          2,
		Title:       "Электрогитара GRETSCH",
		ImageURL:    "https://wellplayedgear.com/cdn/shop/files/products_2FWPG-2508300526-CYGC21120649_2FWPG-2508300526-CYGC21120649_1708505823320.jpg?v=1708505838&width=2048",
		Name:        "Электрогитара GRETSCH",
		Price:       111600,
		Description: "Электрогитара GRETSCH G5622 Electromatic Double-Cut Bristol Fog",
		Specifications: "Количество ладов (диапазон): 22\nКоличество струн: 6\nКонфигурация звукоснимателей: H-h\nКрепление грифа: вклеенный\nМатериал грифа: клён\nМатериал корпуса: клён\nМатериал накладки грифа: лавр\nОриентация: правосторонняя\nФорма корпуса: другая форма\nМензура, дюймы: 24.6",
		Quantity:    0,
	},
	{
		ID:          3,
		Title:       "Электрогитара FENDER",
		ImageURL:    "https://images.musicstore.de/images/0960/fender-vintera-ii-50s-stratocaster-mn-2-color-sunburst_1_GIT0060562-000.jpg",
		Name:        "Электрогитара FENDER",
		Price:       35000,
		Description: "Электрогитара FENDER PLAYER Stratocaster MN 3-Tone Sunburst",
		Specifications: "Количество ладов (диапазон): 22\nКоличество струн: 6\nКонфигурация звукоснимателей: S-s-s\nКрепление грифа: на болтах\nМатериал грифа: клён\nМатериал корпуса: ольха\nМатериал накладки грифа: клён\nМатериал топа: ольха\nОриентация: правосторонняя\nФорма корпуса: Stratocaster",
		Quantity:    0,
	},
	{
		ID:          4,
		Title:       "Электрогитара GIBSON",
		ImageURL:    "https://images.musicstore.de/images/1280/gibson-les-paul-standard-50s-faded-vintage-tobacco-burst_1_GIT0062247-002.jpg",
		Name:        "Электрогитара GIBSON",
		Price:       579000,
		Description: "Электрогитара GIBSON Les Paul Standard 50s Tobacco Burst",
		Specifications: "Количество струн: 6\nКрепление грифа: вклеенный\nМатериал грифа: красное дерево\nМатериал корпуса: красное дерево\nМатериал накладки грифа: палисандр\nМатериал топа: клён\nОриентация: правосторонняя\nФорма корпуса: Les paul\nМензура, дюймы: 24.75\nТип бриджа: Tune-o-matic",
		Quantity:    0,
	},
	{
		ID:          5,
		Title:       "Бас-гитара IBANEZ",
		ImageURL:    "https://www.pult.ru/upload/iblock/307/3072adb6323ced14adfa00f0d1d926f1.jpg",
		Name:        "Бас-гитара IBANEZ",
		Price:       53000,
		Description: "Бас-гитара IBANEZ SR300EB-WK",
		Specifications: "Количество ладов (диапазон): 24\nКоличество струн: 4\nКонфигурация звукоснимателей: H-h\nКрепление грифа: на болтах\nМатериал грифа: клён\nМатериал корпуса: ньятон\nМатериал накладки грифа: ятоба\nОриентация: правосторонняя\nМензура, дюймы: 34\nТип бриджа: фиксированный",
		Quantity:    0,
	},
	{
		ID:          6,
		Title:       "Электрогитара EPIPHONE",
		ImageURL:    "https://impult.ru/preview/r/456x456/upload/iblock/7e7/dliobpyfyvd0a1527p5yumvnq0zevya8.jpg",
		Name:        "Электрогитара EPIPHONE",
		Price:       184000,
		Description: "Электрогитара EPIPHONE 1961 Les Paul SG Standard Aged 60s Cherry",
		Specifications: "",
		Quantity:    0,
	},
	{
		ID:          7,
		Title:       "Электрогитара MOOER",
		ImageURL:    "https://main-cdn.sbermegamarket.ru/hlr-system/109/411/165/372/022/26/600012842365b0.jpeg",
		Name:        "Электрогитара MOOER",
		Price:       56000,
		Description: "Электрогитара MOOER GTRS S800 blue",
		Specifications: "",
		Quantity:    0,
	},
	{
		ID:          8,
		Title:       "Акустическая гитара YAMAHA",
		ImageURL:    "https://ru.yamaha.com/ru/files/252CDAC3C7DF40FEB7CABB9AAAFE3913_12073_6478a866ebd8701062e22a07c9b458b9.jpg?impolicy=resize&imwid=735&imhei=735",
		Name:        "Акустическая гитара",
		Price:       131990,
		Description: "Акустическая гитара YAMAHA FG850 NATURAL",
		Specifications: "",
		Quantity:    0,
	},
	{
		ID:          9,
		Title:       "Классическая гитара YAMAHA",
		ImageURL:    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSNdqfF0TZ-kG7II2Clh5UrEQO2YlyQIqBa4w&s",
		Name:        "Классическая гитара",
		Price:       151990,
		Description: "Классическая гитара YAMAHA SLG200N TRANSLUCENT BLACK",
		Specifications: "Количество струн: 6\nМатериал грифа: красное дерево\nМатериал накладки грифа: палисандр\nОриентация: правосторонняя\nТип классической гитары: со звукоснимателем",
		Quantity:    0,
	},
	{
		ID:          10,
		Title:       "Гитара 12 струн TAKAMINE",
		ImageURL:    "https://images.musicstore.de/images/0320/takamine-gd30ce12-natural_1_GIT0043210-000.jpg",
		Name:        "Гитара 12 струн",
		Price:       70000,
		Description: "Акустическая гитара 12 струн TAKAMINE G70 SERIES GJ72CE-12NAT",
		Specifications: "Количество ладов (диапазон): 21\nКоличество струн: 12\nМатериал грифа: клён\nМатериал корпуса: клён\nМатериал накладки грифа: лавр\nОриентация: правосторонняя\nФорма корпуса: Jumbo\nМензура, дюймы: 25.5\nТип акустической гитары: со звукоснимателем\nМатериал верхней деки: ель",
		Quantity:    0,
	},
}


func getProductsHandler(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Content-Type", "application/json")
	json.NewEncoder(w).Encode(products)
}

func createProductHandler(w http.ResponseWriter, r *http.Request) {
	if r.Method != http.MethodPost {
		http.Error(w, "Invalid request method", http.StatusMethodNotAllowed)
		return
	}

	var newProduct Product
	err := json.NewDecoder(r.Body).Decode(&newProduct)
	if err != nil {
		fmt.Println("Error decoding request body:", err)
		http.Error(w, err.Error(), http.StatusBadRequest)
		return
	}

	fmt.Printf("Received new Product: %+v\n", newProduct)
	var lastID int = len(products)

	for _, productItem := range products {
		if productItem.ID > lastID {
			lastID = productItem.ID
		}
	}
	newProduct.ID = lastID + 1
	products = append(products, newProduct)

	w.Header().Set("Content-Type", "application/json")
	json.NewEncoder(w).Encode(newProduct)
}

func getProductByIDHandler(w http.ResponseWriter, r *http.Request) {
	idStr := r.URL.Path[len("/Products/"):]
	id, err := strconv.Atoi(idStr)
	if err != nil {
		http.Error(w, "Invalid Product ID", http.StatusBadRequest)
		return
	}

	for _, Product := range products {
		if Product.ID == id {
			w.Header().Set("Content-Type", "application/json")
			json.NewEncoder(w).Encode(Product)
			return
		}
	}

	http.Error(w, "Product not found", http.StatusNotFound)
}

func deleteProductHandler(w http.ResponseWriter, r *http.Request) {
	if r.Method != http.MethodDelete {
		http.Error(w, "Invalid request method", http.StatusMethodNotAllowed)
		return
	}

	idStr := r.URL.Path[len("/Products/delete/"):]
	id, err := strconv.Atoi(idStr)
	if err != nil {
		http.Error(w, "Invalid Product ID", http.StatusBadRequest)
		return
	}

	for i, Product := range products {
		if Product.ID == id {
			products = append(products[:i], products[i+1:]...)
			w.WriteHeader(http.StatusNoContent)
			return
		}
	}


	http.Error(w, "Product not found", http.StatusNotFound)
}


func updateProductHandler(w http.ResponseWriter, r *http.Request) {
	if r.Method != http.MethodPut {
		http.Error(w, "Invalid request method", http.StatusMethodNotAllowed)
		return
	}


	idStr := r.URL.Path[len("/Products/update/"):]
	id, err := strconv.Atoi(idStr)
	if err != nil {
		http.Error(w, "Invalid Product ID", http.StatusBadRequest)
		return
	}


	var updatedProduct Product
	err = json.NewDecoder(r.Body).Decode(&updatedProduct)
	if err != nil {
		http.Error(w, err.Error(), http.StatusBadRequest)
		return
	}


	for i, Product := range products {
		if Product.ID == id {

			products[i].Title = updatedProduct.Title
			products[i].ImageURL = updatedProduct.ImageURL
			products[i].Name = updatedProduct.Name
			products[i].Price = updatedProduct.Price
			products[i].Description = updatedProduct.Description
			products[i].Specifications = updatedProduct.Specifications
			products[i].Quantity = updatedProduct.Quantity

			w.Header().Set("Content-Type", "application/json")
			json.NewEncoder(w).Encode(products[i])
			return
		}
	}


	http.Error(w, "Product not found", http.StatusNotFound)
}

func updateProductQuantityHandler(w http.ResponseWriter, r *http.Request) {
	if r.Method != http.MethodPut {
		http.Error(w, "Invalid request method", http.StatusMethodNotAllowed)
		return
	}


	idStr := r.URL.Path[len("/products/quantity/"):]
	id, err := strconv.Atoi(idStr)
	if err != nil {
		http.Error(w, "Invalid Product ID", http.StatusBadRequest)
		return
	}


	var updatedQuantity struct {
		Quantity int `json:"quantity"`
	}
	err = json.NewDecoder(r.Body).Decode(&updatedQuantity)
	if err != nil {
		http.Error(w, err.Error(), http.StatusBadRequest)
		return
	}


	for i, product := range products {
		if product.ID == id {
			products[i].Quantity = updatedQuantity.Quantity
			w.Header().Set("Content-Type", "application/json")
			json.NewEncoder(w).Encode(products[i])
			return
		}
	}


	http.Error(w, "Product not found", http.StatusNotFound)
}


func toggleFavoriteHandler(w http.ResponseWriter, r *http.Request) {
	if r.Method != http.MethodPost {
		http.Error(w, "Invalid request method", http.StatusMethodNotAllowed)
		return
	}


	idStr := r.URL.Path[len("/products/favorite/"):]
	id, err := strconv.Atoi(idStr)
	if err != nil {
		http.Error(w, "Invalid Product ID", http.StatusBadRequest)
		return
	}


	for i, product := range products {
		if product.ID == id {

			products[i].IsFavorite = !products[i].IsFavorite
			w.Header().Set("Content-Type", "application/json")
			json.NewEncoder(w).Encode(products[i])
			return
		}
	}


	http.Error(w, "Product not found", http.StatusNotFound)
}


func toggleCartHandler(w http.ResponseWriter, r *http.Request) {
	if r.Method != http.MethodPost {
		http.Error(w, "Invalid request method", http.StatusMethodNotAllowed)
		return
	}


	idStr := r.URL.Path[len("/products/cart/"):]
	id, err := strconv.Atoi(idStr)
	if err != nil {
		http.Error(w, "Invalid Product ID", http.StatusBadRequest)
		return
	}


	for i, product := range products {
		if product.ID == id {
			products[i].InCart = !products[i].InCart
			w.Header().Set("Content-Type", "application/json")
			json.NewEncoder(w).Encode(products[i])
			return
		}
	}


	http.Error(w, "Product not found", http.StatusNotFound)
}

func main() {
	http.HandleFunc("/products", getProductsHandler)                     // Получить все продукты
	http.HandleFunc("/products/create", createProductHandler)            // Создать продукт
	http.HandleFunc("/products/", getProductByIDHandler)                 // Получить продукт по ID
	http.HandleFunc("/products/update/", updateProductHandler)           // Обновить продукт
	http.HandleFunc("/products/delete/", deleteProductHandler)           // Удалить продукт
	http.HandleFunc("/products/quantity/", updateProductQuantityHandler) // Обновить количество товара
	http.HandleFunc("/products/favorite/", toggleFavoriteHandler)        // Добавить/удалить из избранного
	http.HandleFunc("/products/cart/", toggleCartHandler)                // Добавить/удалить из корзины

	fmt.Println("Server is running on http://localhost:8080 !")
	http.ListenAndServe(":8080", nil)
}