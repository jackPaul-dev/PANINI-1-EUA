import { Router, type IRouter } from "express";
import { HealthCheckResponse } from "@workspace/api-zod";

const router: IRouter = Router();

router.get("/healthz", (_req, res) => {
  const data = HealthCheckResponse.parse({ status: "ok" });
  res.json({
    ...data,
    trackingBase: process.env.TRACKING_BASE_URL ?? "(não definido — usando fallback)",
    emailFrom: process.env.EMAIL_FROM ?? "(não definido)",
  });
});

export default router;
