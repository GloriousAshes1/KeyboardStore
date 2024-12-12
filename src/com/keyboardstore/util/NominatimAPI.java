package com.keyboardstore.util;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;

import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.Response;
import org.json.JSONArray;
import org.json.JSONObject;

public class NominatimAPI {
    public static double[] getCoordinates(String address) {
        String url = null;
        try {
            url = "https://nominatim.openstreetmap.org/search?q=" + URLEncoder.encode(address, "UTF-8") + "&format=json";
        } catch (UnsupportedEncodingException e) {
            throw new RuntimeException(e);
        }
        OkHttpClient client = new OkHttpClient();

        Request request = new Request.Builder()
                .url(url)
                .addHeader("User-Agent", "KeyboardStore")
                .build();

        try (Response response = client.newCall(request).execute()) {
            if (response.isSuccessful()) {
                String jsonResponse = response.body().string();
                JSONArray jsonArray = new JSONArray(jsonResponse);

                if (jsonArray.length() > 0) {
                    JSONObject location = jsonArray.getJSONObject(0);
                    double lat = location.getDouble("lat");
                    double lon = location.getDouble("lon");
                    return new double[]{lat, lon};
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null; // Không tìm được tọa độ
    }

    public static double calculateDistance(String origin, String destination) {
        double[] originCoords = getCoordinates(origin);
        double[] destCoords = getCoordinates(destination);

        if (originCoords != null && destCoords != null) {
            return haversine(originCoords[0], originCoords[1], destCoords[0], destCoords[1]);
        }
        return 0;
    }

    private static double haversine(double lat1, double lon1, double lat2, double lon2) {
        final int R = 6371; // Bán kính Trái Đất (km)
        double dLat = Math.toRadians(lat2 - lat1);
        double dLon = Math.toRadians(lon2 - lon1);
        double a = Math.sin(dLat / 2) * Math.sin(dLat / 2)
                + Math.cos(Math.toRadians(lat1)) * Math.cos(Math.toRadians(lat2))
                * Math.sin(dLon / 2) * Math.sin(dLon / 2);
        double c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
        return R * c; // Khoảng cách theo km
    }
}
