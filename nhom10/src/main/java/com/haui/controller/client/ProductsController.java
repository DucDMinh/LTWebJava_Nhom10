package com.haui.controller.client;

import java.util.List;
import java.util.Arrays;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.haui.model.Product;
import com.haui.service.ProductService;

@Controller
public class ProductsController {

    @Autowired
    private ProductService productService;

    @GetMapping("/products")
    public String productsPage(
            Model model,
            @RequestParam(required = false, defaultValue = "") String search,
            @RequestParam(required = false) String[] category,
            @RequestParam(required = false) String[] factory,
            @RequestParam(required = false) String[] priceRange,
            @RequestParam(required = false) String[] screenSizeRange,
            @RequestParam(required = false, defaultValue = "") String os,
            @RequestParam(required = false, defaultValue = "") String ram,
            @RequestParam(required = false, defaultValue = "") String storage,
            @RequestParam(required = false, defaultValue = "0") Double minPrice,
            @RequestParam(required = false, defaultValue = "999999999") Double maxPrice,
            @RequestParam(required = false, defaultValue = "0") Double minScreenSize,
            @RequestParam(required = false, defaultValue = "99") Double maxScreenSize,
            @RequestParam(required = false, defaultValue = "0") Integer minPin,
            @RequestParam(required = false, defaultValue = "99999") Integer maxPin,
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "20") int size) {

        // Convert arrays to lists for easier handling
        List<String> categoryList = category != null ? Arrays.asList(category) : null;
        List<String> factoryList = factory != null ? Arrays.asList(factory) : null;
        List<String> priceRangeList = priceRange != null ? Arrays.asList(priceRange) : null;
        List<String> screenSizeRangeList = screenSizeRange != null ? Arrays.asList(screenSizeRange) : null;

        // Get all products
        List<Product> allProducts = productService.getAllProduct();

        // Get distinct categories and factories BEFORE filtering for the filter sidebar
        List<String> allCategories = allProducts.stream()
            .map(Product::getCategory)
            .distinct()
            .collect(Collectors.toList());
        model.addAttribute("categories", allCategories);

        List<String> allFactories = allProducts.stream()
            .map(Product::getFactory)
            .distinct()
            .collect(Collectors.toList());
        model.addAttribute("factories", allFactories);

        // Add all filter parameters to model so they persist across pages
        model.addAttribute("search", search);
        model.addAttribute("category", categoryList != null ? categoryList.toArray(new String[0]) : new String[0]);
        model.addAttribute("factory", factoryList != null ? factoryList.toArray(new String[0]) : new String[0]);
        model.addAttribute("priceRange", priceRangeList != null ? priceRangeList.toArray(new String[0]) : new String[0]);
        model.addAttribute("screenSizeRange", screenSizeRangeList != null ? screenSizeRangeList.toArray(new String[0]) : new String[0]);
        model.addAttribute("os", os);
        model.addAttribute("ram", ram);
        model.addAttribute("storage", storage);
        model.addAttribute("minPrice", minPrice);
        model.addAttribute("maxPrice", maxPrice);
        model.addAttribute("minScreenSize", minScreenSize);
        model.addAttribute("maxScreenSize", maxScreenSize);
        model.addAttribute("minPin", minPin);
        model.addAttribute("maxPin", maxPin);

        // Apply filters to get the filtered list
        List<Product> filteredProducts = allProducts.stream()
            .filter(product -> {
                boolean matchesSearch = true;
                if (!search.isEmpty()) {
                    matchesSearch = product.getName().toLowerCase().contains(search.toLowerCase()) ||
                                   product.getShortDesc().toLowerCase().contains(search.toLowerCase()) ||
                                   product.getDetailDesc().toLowerCase().contains(search.toLowerCase());
                }

                boolean matchesCategory = true;
                if (categoryList != null && !categoryList.isEmpty()) {
                    matchesCategory = categoryList.contains(product.getCategory());
                }

                boolean matchesFactory = true;
                if (factoryList != null && !factoryList.isEmpty()) {
                    matchesFactory = factoryList.contains(product.getFactory());
                }

                boolean matchesPrice = product.getPrice() >= minPrice && product.getPrice() <= maxPrice;

                // Apply price range filters if specified
                if (priceRangeList != null && !priceRangeList.isEmpty()) {
                    boolean inAnyRange = false;
                    for (String range : priceRangeList) {
                        String[] bounds = range.split("-");
                        if (bounds.length == 2) {
                            double rangeMin = Double.parseDouble(bounds[0]);
                            double rangeMax = Double.parseDouble(bounds[1]);
                            if (product.getPrice() >= rangeMin && product.getPrice() <= rangeMax) {
                                inAnyRange = true;
                                break;
                            }
                        }
                    }
                    matchesPrice = inAnyRange;
                }

                boolean matchesScreenSize = true;
                if (product.getScreenSize() != null) {
                    matchesScreenSize = product.getScreenSize() >= minScreenSize &&
                                       product.getScreenSize() <= maxScreenSize;
                }

                // Apply screen size range filters if specified
                if (screenSizeRangeList != null && !screenSizeRangeList.isEmpty()) {
                    boolean inAnyRange = false;
                    for (String range : screenSizeRangeList) {
                        String[] bounds = range.split("-");
                        if (bounds.length == 2) {
                            double rangeMin = Double.parseDouble(bounds[0]);
                            double rangeMax = Double.parseDouble(bounds[1]);
                            if (product.getScreenSize() != null &&
                                product.getScreenSize() >= rangeMin &&
                                product.getScreenSize() <= rangeMax) {
                                inAnyRange = true;
                                break;
                            }
                        }
                    }
                    matchesScreenSize = inAnyRange;
                }

                boolean matchesPin = true;
                if (product.getPin() != null) {
                    matchesPin = product.getPin() >= minPin && product.getPin() <= maxPin;
                }

                // Apply OS filter if specified (using the dedicated OS field)
                boolean matchesOS = true;
                if (!os.isEmpty()) {
                    String[] osList = os.split(",");
                    boolean osFound = false;

                    if (product.getOperatingSystem() != null) {
                        for (String osValue : osList) {
                            if (product.getOperatingSystem().toLowerCase().contains(osValue.toLowerCase())) {
                                osFound = true;
                                break;
                            }
                        }
                    }
                    matchesOS = osList.length == 0 || osFound; // If no OS filter is specified, match is true
                }

                // Apply RAM filter - check product variants for RAM info
                boolean matchesRAM = true;
                if (!ram.isEmpty()) {
                    String[] ramList = ram.split(",");
                    boolean ramFound = false;

                    if (product.getProductVariants() != null) {
                        for (String ramValue : ramList) {
                            // Remove "GB" to match numbers only
                            String ramNumber = ramValue.replace("GB", "").trim();

                            // Convert to integer for comparison
                            try {
                                int ramInt = Integer.parseInt(ramNumber);

                                // Check if any variant has matching RAM
                                for (var variant : product.getProductVariants()) {
                                    if (variant.getRam() != null && variant.getRam() == ramInt) {
                                        ramFound = true;
                                        break;
                                    }
                                }

                                if (ramFound) break;
                            } catch (NumberFormatException e) {
                                // Handle invalid RAM values
                                continue;
                            }
                        }
                    }
                    matchesRAM = ramList.length == 0 || ramFound;
                }

                // Apply Storage filter - check product variants for storage info
                boolean matchesStorage = true;
                if (!storage.isEmpty()) {
                    String[] storageList = storage.split(",");
                    boolean storageFound = false;

                    if (product.getProductVariants() != null) {
                        for (String storageValue : storageList) {
                            String storageNumber = storageValue.replace("GB", "").replace("TB", "").trim();

                            // Convert to integer for comparison
                            try {
                                int storageInt = Integer.parseInt(storageNumber);

                                // Check if any variant has matching storage
                                for (var variant : product.getProductVariants()) {
                                    if (variant.getStorage() != null && variant.getStorage() == storageInt) {
                                        storageFound = true;
                                        break;
                                    }
                                }

                                if (storageFound) break;
                            } catch (NumberFormatException e) {
                                // Handle invalid storage values
                                continue;
                            }
                        }
                    }
                    matchesStorage = storageList.length == 0 || storageFound;
                }

                return matchesSearch && matchesCategory && matchesFactory &&
                       matchesPrice && matchesScreenSize && matchesPin &&
                       matchesOS && matchesRAM && matchesStorage;
            })
            .collect(Collectors.toList());

        // Calculate pagination with safety checks
        int totalItems = filteredProducts.size();
        int totalPages = (int) Math.ceil((double) totalItems / size);

        // Ensure page number is valid (prevent crash if user manually inputs ?page=100)
        if (page < 0) page = 0;
        if (page >= totalPages && totalPages > 0) page = totalPages - 1;

        int start = page * size;
        // Safety check for start index
        if (start >= totalItems) start = 0;

        int end = Math.min((start + size), totalItems);

        List<Product> pagedProducts = filteredProducts.subList(start, end);

        model.addAttribute("products", pagedProducts);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalItems", totalItems);
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("pageSize", size);

        return "client/products";
    }
}