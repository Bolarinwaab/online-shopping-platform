function requireAuth(verifier){return async(req,res,next)=>{try{const h=req.headers.authorization||'';if(!h.startsWith('Bearer '))throw new Error('Missing bearer token');req.user=await verifier.verify(h.slice(7));return next();}catch(e){res.writeHead(401,{'Content-Type':'application/json'});return res.end(JSON.stringify({error:'unauthorized'}));}};}
module.exports={requireAuth};
