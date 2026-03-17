package com.foodflow.service;

import com.foodflow.dao.UsageDAO;
import com.foodflow.model.Usage;

public class UsageService {
    private final UsageDAO usageDAO = new UsageDAO();

    public boolean recordUsage(int itemId, double quantity, int userId) {
        return recordUsage(itemId, quantity, userId, "Internal Department");
    }

    public boolean recordUsage(int itemId, double quantity, int userId, String issuedTo) {
        if (itemId <= 0 || quantity <= 0 || userId <= 0) {
            return false;
        }
        Usage usage = new Usage();
        usage.setItemId(itemId);
        usage.setQuantity(quantity);
        usage.setRecordedBy(userId);
        usage.setIssuedTo(issuedTo);
        usage.setStatus(Usage.Status.ISSUED);
        return usageDAO.addUsage(usage);
    }
}
